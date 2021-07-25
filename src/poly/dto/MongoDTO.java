package poly.dto;

public class MongoDTO {

    String date;            // 입력된 날짜
    String SENSOR_NUMBER;   // 센서 번호
    String SENSOR_DATA;     // 센서에 입력된 값

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSENSOR_NUMBER() {
        return SENSOR_NUMBER;
    }

    public void setSENSOR_NUMBER(String SENSOR_NUMBER) {
        this.SENSOR_NUMBER = SENSOR_NUMBER;
    }

    public String getSENSOR_DATA() {
        return SENSOR_DATA;
    }

    public void setSENSOR_DATA(String SENSOR_DATA) {
        this.SENSOR_DATA = SENSOR_DATA;
    }
}
