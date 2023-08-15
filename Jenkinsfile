pipeline
{
    agent any
    stages
    {
        stage("clone code")
        {
            steps
            {
                script
                {
                    cleanWs()
                    sh """
                        git clone https://github.com/sravya-07/myapp.git
                        echo "build number: $BUILD_NUMBER"
                        whoami
                    """
                }
            }
        }
        
        stage("mvn clean install")
        {
            steps
            {
                script
                {
                    sh"""
                        cd $WORKSPACE/myapp
                        mvn clean install -DskipTests
                    """
                }
            }
        }
        
        stage("put artifact in aws s3")
        {
            steps
            {
                script
                {
                    sh"""
                     cd $WORKSPACE/myapp/target
                     aws s3api put-object --bucket myapp-artifacts-12523 --key myappartifact-latest.jar --body spring-rest-hello-world-1.0.jar
                    """
                }
            }
        }
        
        stage("build the docker image")
        {
            steps
            {
                script
                {
                    sh """
                        cd $WORKSPACE/myapp
                        sudo docker build . -t myapp-image:$BUILD_NUMBER
                        sudo docker tag myapp-image:$BUILD_NUMBER myapp-image:latest
                    """
                }
            }
        }
        
        stage("push image to docker registry")
        {
            steps
            {
                script
                {
                    sh """
                         sudo docker tag myapp-image:$BUILD_NUMBER 996405149242.dkr.ecr.us-east-1.amazonaws.com/myapp:$BUILD_NUMBER
                         sudo docker push 996405149242.dkr.ecr.us-east-1.amazonaws.com/myapp:$BUILD_NUMBER
                    """
                }
            }
        }
    }
}
