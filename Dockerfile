# Copyright 2015 Akamai Technologies, Inc. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at 
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM python:2.7.10
MAINTAINER Kirsten Hunter (khunter@akamai.com)
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl libssl-dev python-all wget vim python-pip php5 ruby-dev nodejs-dev npm php-pear php5-dev ruby perl5 
RUN pip install httpie-edgegrid 
ADD ./examples /opt/examples
ADD ./contrib/python /opt/examples/python/contrib
WORKDIR /opt/examples/ruby
RUN gem install bundler
RUN bundler install
WORKDIR /opt/examples/node
RUN npm install
WORKDIR /opt/examples/python
RUN python /opt/examples/python/tools/setup.py install
ADD ./MOTD /opt/MOTD
RUN echo "alias gen_edgerc python /opt/examples/python/gen_edgerc.py"
RUN echo "cat /opt/MOTD" >> /root/.bashrc
RUN mkdir /.httpie
ADD ./config.json /.httpie/config.json
ENTRYPOINT ["/bin/bash"]
