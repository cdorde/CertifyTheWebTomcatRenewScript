## Certify The Web - Hook script for recreating keystore (jks) for Tomcat

Prerequites

1. OpenSSL instalation
2. Working CertifyTheWeb client

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
    
<TOMCAT WINDOWS SERVICE NAME - NOT DISPLAY NAME>
    example value: tomcat 8
```
