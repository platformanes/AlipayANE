AlipayANE
=========

## 支付宝ANE  for IOS for android(SDK版本 1.0.1)
包含以下内容：
* Alipay ANE for Android 安卓端ANE
* Alipay ANE for IOS 苹果移动端ANE
* IOS端url若要调用则需要修改-app.xml 在[iphone]标签中加入URL
* IOS端支付宝库请自行下载
* sample 对于android和IOS均适用 关于环境配置不在赘述

## 资源

* 官方SDK[Alipay](http://club.alipay.com/read-htm-tid-9976972.html) 

## 编译方法
* 查看Bulid文件夹下的Bulid ANE文件夹(ane.bat for win,ane.sh for mac)
* 查看Bulid文件夹下的Bulid APK文件夹
* 温馨提示：Alipay.bundle资源需要放到AIR根目录，否则会发生资源取不到的问题

##　iOS版本特别提醒

iOS支付回调使用Url的方式  详细配置查看`aneTest`文件夹下的`-app.xml`文件 [IPHONE](https://github.com/platformanes/AlipayANE/blob/master/aneTest/src/AlipaySample-app.xml)标签处
`294`-`316`行.

```
 <iPhone>
        <InfoAdditions><![CDATA[
			<key>UIDeviceFamily</key>
			<array>
				<string>1</string>
				<string>2</string>
			</array>
			
			<key>CFBundleURLTypes</key> 
			<array> 
	    	<dict> 
	        	 <key>CFBundleURLSchemes</key> 
    	    	<array> 
        		    <string>AlipayANE</string> 
    	    	</array> 
    	    	<key>CFBundleURLName</key> 
    	    	<string>com.rect.app</string> 
    		</dict> 
		</array>

		]]></InfoAdditions>
        <requestedDisplayResolution>high</requestedDisplayResolution>
    </iPhone>
```

## 作者

* [platformANEs](https://github.com/platformanes)由 [zrong](http://zengrong.net) 和 [rect](http://www.shadowkong.com/) 共同发起并完成。

## MIT 

The MIT License (MIT)(有网友需要 就贴一个)

    Copyright (c) 2010-2014 www.shadowkong.com
    
    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
