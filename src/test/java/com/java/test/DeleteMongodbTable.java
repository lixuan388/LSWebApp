package com.java.test;


import org.bson.Document;

import com.java.sql.MongoCon;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class DeleteMongodbTable {
  public void Delete(String TableName)
  {
    MongoDatabase database = MongoCon.GetConnect();

    MongoCollection<Document> collection = database.getCollection(TableName);
    collection.drop();

    System.out.println("删除Mongodb表：" +TableName);
  }

}
