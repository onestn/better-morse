package poly.persistance.mongo;

import poly.dto.MongoDTO;

import java.util.List;

public interface IMongoMapper {

    List<MongoDTO> getDatas(String colNm) throws Exception;
}
