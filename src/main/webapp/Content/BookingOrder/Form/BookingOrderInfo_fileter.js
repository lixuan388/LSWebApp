
app.filter('CurrencyFormat', function() { //可以注入依赖
    return function(text) {
      if (!isNaN(text)){
        var f=text*1.00;
        return f.toFixed(2);
      }
      else{
        console.log(text);
        if (text==''|| text==undefined){
          return '0.00';
        }
        else{
          return text;
        }
      }
    }
});

app.filter('CountryNameFormat', function() { //可以注入依赖
    return function(text) {
//      console.log('CountryNameFormat:'+text);
      if (!isNaN(text)){

        return CountryName[text];
      }
      else{
        return text;
      }
    }
});
app.filter('AreaNameFormat', function() { //可以注入依赖
  return function(text) {
//    console.log('CountryNameFormat:'+text);
    if (!isNaN(text)){

      return VisaAreaName[text];
    }
    else{
      return text;
    }
  }
});
app.filter('ProductTypeNameFormat', function() { //可以注入依赖
  return function(text) {
//    console.log('CountryNameFormat:'+text);
    if (!isNaN(text)){

      return ProductTypeName[text];
    }
    else{
      return text;
    }
  }
});

var InvoiceTypeName={'1':'增值税专用发票','2':'增值税普通发票','3':'增值税电子普通发票'}

app.filter('InvoiceTypeFormat', function() { //可以注入依赖
  return function(text) {
//    console.log('InvoiceTypeFormat:'+text);
//    console.log('InvoiceTypeFormat:'+isNaN(text));
//    if (text == undefined){
//      return '';
//    }
//    else
    if (!isNaN(text)){

      return InvoiceTypeName[text];
    }
    else{
      return text;
    }
  }
});


app.filter('PassPortFormat', function() { //可以注入依赖
  return function(text) {
//    console.log('CountryNameFormat:'+text);
    if (text==''){
      return '护照未录入';
    }
    else{
      return text;
    }
  }
});

app.filter('DateTimeFormat', function() { //可以注入依赖
    return function(text) {
      return text.substring(0,19);
    }
});