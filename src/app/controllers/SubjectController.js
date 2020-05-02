const Yup = require('yup');
const ResponseHandlers = require('../../utils/ResponseHandlers');
const Subject = require('../models/Subject');
class SubjectController {
  async store(req, res) {
    const schema = Yup.object().shape({
      subject: Yup.string().required('You must provide the subject'),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        const { subject } = req.body;

        const subjectExists = await Subject.findOne({
          where: { subject: subject },
        });

        if (subjectExists) {
          return res.status(400).json({
            code: 400,
            error: {
              field: 'subject',
              message: `Deck subject ${subjectExists} already exists`
            },
            message: `Deck subject ${subjectExists} already exists`
          });
        }

        const subjectData = await Subject.create({ subject });


        return res.status(201).json({
          code: 201,
          data: subjectData,
          message: 'The subject was created successfully'
        })
      })
      .catch((err) => {
        return res.status(400).json({
          code: 400,
          errors: ResponseHandlers.convertYupValidationErrors(err),
          message: 'There are errors on the data you provided',
        });
      });
    
  }

  async index(req, res) {
    const subjects = await Subject.findAll();

    return res.status(200).json({
      code: 200,
      data: subjects,
      message: 'Subjects'
    });
  }
}

module.exports = new SubjectController();
