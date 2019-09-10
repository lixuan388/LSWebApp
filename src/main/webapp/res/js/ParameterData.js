function GetParameterData(name)
{
  
  return layui.data(WebConfig.tableName+'.'+name+'.Json').json;
}

function SetParameterData(name,json)
{
  layui.data(WebConfig.tableName+'.'+name+'.Json',{'key':'json','value':json});
}