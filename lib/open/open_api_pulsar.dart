//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import 'package:paas_dashboard_flutter/api/pulsar/pulsar_partitioned_topic_api.dart';
import 'package:paas_dashboard_flutter/persistent/persistent.dart';

class OpenApiPulsar {
  Future<int> partitionTopicCount(String name, String tenant, String namespace) async {
    var pulsarInstance = await Persistent.pulsarInstance(name);
    if (pulsarInstance == null) {
      throw ArgumentError("pulsar instance not exist");
    }
    var list = await PulsarPartitionedTopicApi.getTopics(pulsarInstance.host, pulsarInstance.port, tenant, namespace);
    return list.length;
  }
}
