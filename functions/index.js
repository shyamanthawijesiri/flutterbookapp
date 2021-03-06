const functions = require('firebase-functions');
const cors = require('cors')({ origin: true })
const os = require('os');
const path = require('path');
const fs = require('fs');
const Busboy = require('busboy');
const admin = require('firebase-admin');
const { v4: uuid } = require('uuid');
const {Storage} = require('@google-cloud/storage');
const gcs = new Storage({keyFilename: "flutter-product.json"});
// const gcconfig = {
//     projectId: 'flutter-product-80e90',
//     keyFilename: 'flutter-product.json'
// }
//const gcs = require('@google-cloud/storage')(gcconfig);
var serviceAccount = require("./flutter-product.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),

});

exports.storeImage = functions.https.onRequest((req, res) => {
    return cors(req, res, () => {
        if (req.method !== 'POST') {
            return res.status(500).json({ message: 'Not Allow' });
        }

        if (!req.headers.authorization || !req.headers.authorization.startsWith('Bearer ')) {
            return res.status(401).json({ error: 'Unauthorized!!!' });

        }
        let idToken;
        idToken = req.headers.authorization.split('Bearer ')[1];

        const busboy = new Busboy({ headers: req.headers });
        let uploadData;
        let oldImagePath;
        busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
            const filePath = path.join(os.tmpdir(), filename);
            uploadData = { filePath: filePath, type: mimetype, name: filename };
            file.pipe(fs.createWriteStream(filePath));

        });
        busboy.on('field', (fieldname, value) => {
            oldImagePath = decodeURIComponent(value);
        });

        busboy.on('finish', () => {
            const bucket = gcs.bucket('flutter-product-80e90.appspot.com');
            const id = uuid();
            let imagePath = 'images/' + id + '-' + uploadData.name;
            if (oldImagePath) {
                imagePath = oldImagePath;
            }
            return admin.auth()
                .verifyIdToken(idToken)
                .then(decodeToken => {
                    return bucket.upload(uploadData.filePath, {
                        uploadType: 'media',
                        destination: imagePath,
                        metadata: {
                            metadata: {
                                contentType: uploadData.type,
                                firebaseStorageDownloadTokens: id
                            }
                        }
                    });
                })
                .then(() => {
                    return res.status(201).json({
                        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' + bucket.name + '/o/' + encodeURIComponent(imagePath) + '?alt=media&token=' + id,
                        imagePath: imagePath
                        
                  
                        
                    });
                })
                .catch(error => {
                    return res.status(401).json({ error: 'unauthorized' })
                })

        });
        return busboy.end(req.rawBody);
    })
})

