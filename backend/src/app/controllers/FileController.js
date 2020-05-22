const File = require('../models/File');

class FileController {
  async store(req, res) {
    try {
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
      const { originalname: name, filename: path, mimetype: type } = req.file;
  
      const file = await File.create({
        name,
        path,
        type
      });
  
      return res.status(201).json({
        code: 201,
        data: file,
        message: 'The file was uploaded successfully'
      });
    } catch (err) {
      return res.status(500).json({
        code: 500,
        error: err.name,
        messsage: 'A server error has ocurred'
      })
    }
  }
}

module.exports = new FileController();
