REM On Windows 10+, get the required binaries (need 7zip to extract Tomcat)
rmdir bin/ /s /q
mkdir bin
cd bin

curl --output tomcat.tar.gz --url https://downloads.apache.org/tomcat/tomcat-9/v9.0.39/bin/apache-tomcat-9.0.39.tar.gz
"C:\Program Files\7-Zip\7z.exe" x "tomcat.tar.gz" -so | "C:\Program Files\7-Zip\7z.exe" x -aoa -si -ttar
curl --location --output jenkins-LATEST.war --url https://get.jenkins.io/war/latest/jenkins.war