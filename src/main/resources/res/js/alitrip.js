

//主订单状态。交易状态。
Trades_Status={
		TRADE_NO_CREATE_PAY:'没有创建支付宝交易',
		WAIT_BUYER_PAY:'等待买家付款',
		SELLER_CONSIGNED_PART:'卖家部分发货',
		WAIT_SELLER_SEND_GOODS:'等待卖家发货',
		WAIT_BUYER_CONFIRM_GOODS:'等待买家确认收货',
		TRADE_FINISHED:'交易成功',
		TRADE_CLOSED:'付款以后用户退款成功',
		TRADE_CLOSED_BY_TAOBAO:'关闭交易',
		PAY_PENDING:'国际信用卡支付付款确认中'
}

VisaStateName={
	// TODO Auto-generated method stub
	1001:"无办理人信息",
	1002: "办理人已填写",
	1003: "已收到资料",
	1004: "已审核完成",
	1005: "已送签",
	1006: "结果已返回",
	1007: "已预约面试",
	1008: "处理中",
	1009: "买家已填写反馈信息",
	1010: "已中止办理",
	1012: "需补充资料",
  1014: "已退回资料",
  1013: "已寄回结果",
	1015: "结果返回"
}


function GetTradesStatus(value)
{
	if (Trades_Status[value])
	{
		return Trades_Status[value];
	}
	else
	{
		return value;
	}
}


