#!/bin/bash

ENV=$1
VERSION=$2

echo "🚀 Deploying version $VERSION to $ENV..."

TARGET_HOST="ec2-user@13.218.47.134"
APP_DIR="/home/ec2-user/myapp"

scp myapp-${VERSION}.zip $TARGET_HOST:/tmp/

ssh $TARGET_HOST <<EOF
  mkdir -p $APP_DIR
  unzip -o /tmp/myapp-${VERSION}.zip -d $APP_DIR
  cd $APP_DIR
  nohup python3 app.py > output.log 2>&1 &
EOF

echo "✅ Deployment complete!"

