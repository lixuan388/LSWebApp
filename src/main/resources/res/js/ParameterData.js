function GetParameterData(name)
{
  
  return layui.data('ls.layuiAdmin.'+name+'.Json').json;
}

function SetParameterData(name,json)
{
  layui.data('ls.layuiAdmin.'+name+'.Json',{'key':'json','value':json});
}