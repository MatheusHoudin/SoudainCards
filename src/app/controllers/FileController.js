const File = require('../models/File');

class FileController {
  async store(req, res) {
    if (typeof req.file == 'undefined') {
      return res.status(400).json({
        code: 400,
        error: {
          field: 'file',
          message: 'File was not provided'
        },
        message: 'You must provide a file to save'
      })
    }
    console.log(!req.file.mimetype.includes('image'));
    if( !req.file.mimetype.includes('image') ) {
      return res.status(401).json({
        code: 401,
        error: {
          field: 'file',
          message: 'Invalid file type'
        },
        message: 'You must provide an image to save'
      })
    }
    const { originalname: name, filename: path } = req.file;

    const file = await File.create({
      name,
      path,
    });

    return res.json(file);
  }
}

module.exports = new FileController();
