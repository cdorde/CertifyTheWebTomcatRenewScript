## Certify The Web - Hook script for recreating keystore (jks) for Tomcat for older versions

Newer version of clinet has option Deploy to Tomcat.

Prerequites

1. OpenSSL instalation
2. Working CertifyTheWeb client
3. Working Apache Tomcat installation with SSL connector

How to

1. create script file
2. start CertifyTheWeb client and add script as hook 

Script template:

```
param($result)

if($result.IsSuccess) {
    del <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE> -ErrorAction SilentlyContinue
    <PATH TO OPENSSL.EXE> pkcs12 -in $result.ManagedItem.CertificatePath -out <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE> -passout pass:password -passin pass:
    <PATH TO OPENSSL.EXE> pkcs12 -export -in <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE> -out <PATH TO JKS FILE> -name <KEY ALIAS> -passin pass:password -passout file:<PATH TO PASSWORD FILE>
    del <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE>
    Restart-Service -Name <TOMCAT WINDOWS SERVICE NAME - NOT DISPLAY NAME>
    return "Keystore succesfully created and Tomcat8 service restarted"
} else {
    return "Script did not receive parameters or cert renew was unsuccesfull!"
} 
```

Example of Tomcat SSL connector configuration

```
	<Connector
           protocol="org.apache.coyote.http11.Http11NioProtocol"
           port="8443" maxThreads="200"
		   relaxedPathChars='[]|'
		   relaxedQueryChars='[]|'
           scheme="https" secure="true" SSLEnabled="true"
           keystoreFile="<PATH TO JKS FILE>" keystorePass="<KEYSTORE_PASSWORD>" keyAlias="<KEY ALIAS>"
           clientAuth="false" sslProtocol="TLS"/>
```

Examples of parameters

```
<PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE>
    example value: c:\TEMP\temp.pem

<PATH TO OPENSSL.EXE>
    example value: C:\openssl-1.1.1\x64\bin\openssl.exe
    
<PATH TO JKS FILE>
    example value: c:\tomcat.jks

<KEY ALIAS>
    example value: key1

<PATH TO PASSWORD FILE>
    example value: c:\Users\Administrator\password.txt
    file content: PleasedontuseDOBaspa$$w0rd!
    
<KEYSTORE_PASSWORD> - must be the same as file content of <PATH TO PASSWORD FILE>
    example value: PleasedontuseDOBaspa$$w0rd!
    
<TOMCAT WINDOWS SERVICE NAME - NOT DISPLAY NAME>
    example value: tomcat8
```
