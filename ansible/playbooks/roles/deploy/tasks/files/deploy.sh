npx kill-port 8080
mvn validate
mvn clean
mvn compile
mvn test
mvn package
nohup java -jar /home/ubuntu/GoldenWaste/target/goldenWastedd-0.0.1-SNAPSHOT.jar --log=stdout > ngrok.log &