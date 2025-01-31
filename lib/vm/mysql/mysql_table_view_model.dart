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

import 'package:paas_dashboard_flutter/api/mysql/mysql_databases_api.dart';
import 'package:paas_dashboard_flutter/module/mysql/mysql_table.dart';
import 'package:paas_dashboard_flutter/persistent/po/mysql_instance_po.dart';

import 'package:paas_dashboard_flutter/vm/base_load_list_page_view_model.dart';

class MysqlTablesViewModel extends BaseLoadListPageViewModel<TableResp> {
  List<TableResp> tables = <TableResp>[];

  MysqlInstancePo mysqlInstancePo;

  String dbname;

  String? tableName;

  MysqlTablesViewModel(this.mysqlInstancePo, this.dbname);

  int get id {
    return this.mysqlInstancePo.id;
  }

  String get name {
    return this.mysqlInstancePo.name;
  }

  String get host {
    return this.mysqlInstancePo.host;
  }

  String get username {
    return this.mysqlInstancePo.username;
  }

  String get password {
    return this.mysqlInstancePo.password;
  }

  int get port {
    return this.mysqlInstancePo.port;
  }

  String getDbname() {
    return this.dbname;
  }

  String getTableName() {
    return this.tableName == null ? "" : this.tableName!;
  }

  Future<void> fetchMysqlTables() async {
    try {
      this.fullList = await MysqlDatabaseApi.getTableList(host, port, username, password, dbname);
      this.displayList = this.fullList;
      loadSuccess();
    } on Exception catch (e) {
      loadException = e;
      loading = false;
    }
    notifyListeners();
  }

  Future<void> filter(String str) async {
    if (str == "") {
      this.displayList = this.fullList;
      notifyListeners();
      return;
    }
    if (!loading && loadException == null) {
      this.displayList = this.fullList.where((element) => element.tableName.contains(str)).toList();
    }
    notifyListeners();
  }

  MysqlTablesViewModel deepCopy() {
    return new MysqlTablesViewModel(mysqlInstancePo.deepCopy(), dbname);
  }
}
