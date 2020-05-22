const successResponseModel = ({ code, data, message }) => {
  code, data, message;
};

const errorResponseModel = ({ code, error, message }) => {
  code, error, message;
};

const convertYupValidationErrors = (err) => {
  return err.inner.map((e) => {
    return { field: e.path, message: e.message };
  });
};

module.exports = {
  successResponseModel,
  errorResponseModel,
  convertYupValidationErrors,
};
