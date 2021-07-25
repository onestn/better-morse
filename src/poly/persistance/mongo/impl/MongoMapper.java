package poly.persistance.mongo.impl;

import com.mongodb.Block;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.MongoCollection;
import config.Mapper;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import poly.dto.MongoDTO;
import poly.persistance.mongo.IMongoMapper;
import poly.persistance.mongo.comm.AbstractMongoDBComon;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Mapper("MongoMapper")
public class MongoMapper extends AbstractMongoDBComon implements IMongoMapper {

    @Autowired
    private MongoTemplate mongodb;

    private Logger log = Logger.getLogger(this.getClass());

    @Override
    public List<MongoDTO> getDatas(String colNm) throws Exception {
        log.info(this.getClass().getName() + ".get Datas Start!");

        List<MongoDTO> rList = new ArrayList<>();

        MongoCollection<Document> collection = mongodb.getCollection(colNm);

        // collection의 전체 데이터
        FindIterable<Document> findIterable = collection.find(new Document());

        Iterator<Document> cursor = findIterable.iterator();

        while(cursor.hasNext()) {
            Document doc = cursor.next();

            if (doc == null) {
                doc = new Document();
            }

            String Date = doc.getString("date");
            String SensorNum = doc.getString("SENSOR_NUMBER");
            String SensorData = doc.getString("SENSOR_DATA");

            MongoDTO rDTO = new MongoDTO();

            rDTO.setDate(Date);
            rDTO.setSENSOR_NUMBER(SensorNum);
            rDTO.setSENSOR_DATA(SensorData);

            rList.add(rDTO);

            rDTO = null;
            doc = null;
        }

        log.info(this.getClass().getName() + ".get Datas End!");

        return rList;
    }
}
