echo "making ane now"
/Users/kkfun/rect/AIRSDK/bin/adt -package -storetype PKCS12 -keystore qlwx.p12 -storepass 1234 -target ane com.alipay.ane extension.xml -swc *.swc -platform iPhone-ARM -C iPhone-ARM . -platform Android-ARM -C Android-ARM .
echo "shell over,please check the dir"