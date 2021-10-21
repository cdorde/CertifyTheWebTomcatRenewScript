## Certify The Web - Hook script for recreating keystore (jks) for Tomcat

###Prerquites

1. OpenSSL instalation
2. Java installation

###Scrtipt template:

```
param($result)

if($result.IsSuccess) {
    del <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE> -ErrorAction SilentlyContinue
    <PATH TO OPENSSL.EXE> pkcs12 -in $result.ManagedItem.CertificatePath -out <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE> -passout pass:password -passin pass:
    <PATH TO OPENSSL.EXE> pkcs12 -export -in c:\TEMP\temp.pem -out c:\keycloak.jks -name "bg-dev" -passin pass:password -passout file:<PATH TO PASSWORD FILE>
    del <PATH TO TEMPORARY LOCATION FOR SAVING PEM FILE>
    Restart-Service -Name <TOMCAT WINDOWS SERVICE NAME - NOT DISPLAY NAME>
    return "Keystore succesfully created and Tomcat8 service restarted"
} else {
    return "Script did not receive parameters or cert renew was unsuccesfull!"
} 
```
