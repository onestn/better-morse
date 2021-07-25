package test;

import poly.util.EncryptUtil;

public class EncryptTest {
    public static void main(String[] args) throws Exception {

        System.out.println("---------------------");
        System.out.println("HASH ENCRYPT ALGORITHM");

        // 암호화할 문자열
        String str = "TEST TEST TEST";

        String hashEnc = EncryptUtil.encHashSHA256(str);

        System.out.println("Hash Enc : " + hashEnc);
        // Hash Enc : 2224c7298e839f9307fbcf4266cc47cb667c94e5bc659857729c7ba3e2784245
        System.out.println("---------------------");

        System.out.println("AES128-CBC 암, 복호화 알고리즘");

        String enc = EncryptUtil.encAES128CBC(str);

        System.out.println("Enc : " + enc);

        String dec = EncryptUtil.decAES128CBC(enc);

        System.out.println("Dec : " + dec);

        System.out.println("---------------------");
    }
}
