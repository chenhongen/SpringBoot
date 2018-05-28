package com.che;

import java.io.StringReader;
import java.net.URL;

import javax.xml.ws.Dispatch;
import javax.xml.ws.Service;
import javax.xml.ws.Service.Mode;

import org.apache.cxf.staxutils.StaxUtils;

import javax.xml.namespace.QName;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

/**
 * 客户端
 * @author cxf,che
 *
 */
public class CXFClient {
	public static void main(String[] args) throws Exception {
        String address = "http://localhost:8080/Service/Hello";
        String request = "<q0:sayHello xmlns:q0=\"http://service.che.com/\"><myname>Che</myname></q0:sayHello>";

        StreamSource source = new StreamSource(new StringReader(request));
        Service service = Service.create(new URL(address + "?wsdl"), 
                                         new QName("http://service.che.com/" , "HelloService"));
        Dispatch<Source> disp = service.createDispatch(new QName("http://service.che.com/" , "HelloPort"),
                                                       Source.class, Mode.PAYLOAD);
        
        Source result = disp.invoke(source);
        String resultAsString = StaxUtils.toString(result);
        System.out.println("-------------------------------------- RESULT -------------------------------");
        System.out.println(resultAsString);
       
    }
}
