param($result)

if($result.IsSuccess) {
    del c:\TEMP\temp.pem -ErrorAction SilentlyContinue
    c:\openssl-1.1\x64\bin\openssl.exe pkcs12 -in $result.ManagedItem.CertificatePath -out c:\TEMP\temp.pem -passout pass:password -passin pass:
    c:\openssl-1.1\x64\bin\openssl pkcs12 -export -in c:\TEMP\temp.pem -out c:\keycloak.jks -name "bg-dev" -passin pass:password -passout file:C:\Users\Administrator\passout.txt
    del c:\TEMP\temp.pem
    Restart-Service -Name Tomcat8
    return "Keystore succesfully created and Tomcat8 service restarted"
} else {
    return "Script did not receive parameters or cert renew was unsuccesfull!"
} 
