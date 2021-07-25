package poly.persistance.mongo.impl;

import com.mongodb.client.MongoCollection;
import config.Mapper;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import poly.persistance.mongo.IMongoTestMapper;
import poly.persistance.mongo.comm.AbstractMongoDBComon;

@Mapper("MongoTestMapper")
public class MongoTestMapper extends AbstractMongoDBComon implements IMongoTestMapper {

    @Autowired
    private MongoTemplate mongodb;

    private Logger log = Logger.getLogger(this.getClass());

    @Override
    // str에 들어갈 값을 받아 MongoDB.colNm에 저장함
    public int insertWrongCh(String str, String colNm, String user_id) throws Exception {

        log.info(this.getClass().getName() + ".insertWrongCh Start!");

        int res = 0;

        boolean bool = true;
        // 데이터를 저장할 컬렉션 생성
        bool = super.createCollection(colNm);

        if (bool == false) {
            log.info("컬렉션이 이미 존재함");
        } else {
            log.info("컬렉션이 만들어짐");
        }

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> col = mongodb.getCollection(colNm);
        // MongoDB의 기본 값 타입인 Document
        Document doc = new Document();
        doc.append("user_id", user_id);
        // wrongCh: str로 JSON에 추가
        doc.append("wrongCh", str);
        // INSERT
        col.insertOne(doc);

        doc = null;
        col = null;

        res = 1;

        log.info(this.getClass().getName() + ".insertWrongCh END!");

        return res;

    }
}
