dynamic errorHandling(resStatus) {
  var res = {'status': false, 'message': ""};
  switch (resStatus) {
    case 400:
      res['message'] = 'Invalid Input Data';
      break;
    case 401:
    case 403:
      res['message'] = 'Unauthorised, Please login';
      break;
    case 500:
    default:
      res['message'] = 'Error occurred while Communication with Server';
      break;
  }
  return res;
}
