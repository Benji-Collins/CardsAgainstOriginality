#!/bin/bash

mvn clean package war:war -Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false -Dmaven.test.skip=true
