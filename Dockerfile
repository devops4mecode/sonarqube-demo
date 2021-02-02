FROM sonarqube:7.0

ENV SONARQUBE_HOME /opt/sonarqube

RUN wget "https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-5.3.0.13828.jar" \
    && wget "https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-4.1.0.6085.jar" \
    && wget "https://sonarsource.bintray.com/Distribution/sonar-typescript-plugin/sonar-typescript-plugin-1.6.0.2388.jar" \
    && mv *.jar $SONARQUBE_HOME/extensions/plugins \
    && ls -lah $SONARQUBE_HOME/extensions/plugins