-- Copyright 2021 Google LLC
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- This SQL extracts all info from the DBC.QryLogV table except for ElapsedTime,
-- ErrorText and TDWMMSRCount.
SELECT
  "AbortFlag",
  "AcctString",
  "AcctStringDate",
  "AcctStringHour",
  "AcctStringTime",
  "AMPCPUTime",
  "AMPCPUTimeNorm",
  "AppID",
  "CacheFlag",
  "CalendarName",
  "CallNestingLevel",
  "CheckpointNum",
  "ClientAddr",
  "ClientID",
  "QryLogV"."CollectTimeStamp" AT TIME ZONE INTERVAL '0:00' HOUR TO MINUTE AS "CollectTimeStamp",
  "CPUDecayLevel",
  "DataCollectAlg",
  "DBQLStatus",
  "DefaultDatabase",
  "DelayTime",
  "DisCPUTime",
  "DisCPUTimeNorm",
-- The "Inverval" type is not fully supported yet.
--  "ElapsedTime",
  "ErrorCode",
-- jdbc would throw an error if we add ErrorText in the query.
--  "ErrorText",
  "EstMaxRowCount",
  "EstMaxStepTime",
  "EstProcTime",
  "EstResultRows",
  "ExpandAcctString",
  "FirstRespTime" AT TIME ZONE INTERVAL '0:00' HOUR TO MINUTE AS "FirstRespTime",
  "FirstStepTime" AT TIME ZONE INTERVAL '0:00' HOUR TO MINUTE AS "FirstStepTime",
  "FlexThrottle",
  "ImpactSpool",
  "InternalRequestNum",
  "IODecayLevel",
  "IterationCount",
  "KeepFlag",
  "LastRespTime",
  "LockDelay",
  "LockLevel",
  "LogicalHostID",
  "LogonDateTime" AT TIME ZONE INTERVAL '0:00' HOUR TO MINUTE AS "LogonDateTime",
  "LogonSource",
  "LSN",
  "MaxAMPCPUTime",
  "MaxAMPCPUTimeNorm",
  "MaxAmpIO",
  "MaxCPUAmpNumber",
  "MaxCPUAmpNumberNorm",
  "MaxIOAmpNumber",
  "MaxNumMapAMPs",
  "MaxOneMBRowSize",
  "MaxStepMemory",
  "MaxStepsInPar",
  "MinAmpCPUTime",
  "MinAmpCPUTimeNorm",
  "MinAmpIO",
  "MinNumMapAMPs",
  "MinRespHoldTime",
  "NumFragments",
  "NumOfActiveAMPs",
  "NumRequestCtx",
  "NumResultOneMBRows",
  "NumResultRows",
  "NumSteps",
  "NumStepswPar",
  "ParamQuery",
  "ParserCPUTime",
  "ParserCPUTimeNorm",
  "ParserExpReq",
  "PersistentSpool",
  "QryLogV"."ProcID",
  "ProfileID",
  "ProfileName",
  "ProxyRole",
  "ProxyUser",
  "ProxyUserID",
  "QueryBand",
  "QryLogV"."QueryID",
  "QueryRedriven",
  "QueryText",
  "ReDriveKind",
  "RemoteQuery",
  "ReqIOKB",
  "ReqPhysIO",
  "ReqPhysIOKB",
  "RequestMode",
  "RequestNum",
  "SeqRespTime",
  "SessionID",
  "SessionTemporalQualifier",
  "SpoolUsage",
  "StartTime" AT TIME ZONE INTERVAL '0:00' HOUR TO MINUTE AS "StartTime",
  "StatementGroup",
  "Statements",
  "StatementType",
  "SysDefNumMapAMPs",
  "TacticalCPUException",
  "TacticalIOException",
  "TDWMEstMemUsage",
-- TDWMMSRCount is not found in the table.
--  "TDWMMSRCount",
  "ThrottleBypassed",
  "TotalFirstRespTime",
  "TotalIOCount",
  "TotalServerByteCount",
  "TTGranularity",
  "TxnMode",
  "TxnUniq",
  "UnitySQL",
  "UnityTime",
  "UsedIota",
  "UserID",
  "UserName",
  "UtilityByteCount",
  "UtilityInfoAvailable",
  "UtilityRowCount",
  "VHLogicalIO",
  "VHLogicalIOKB",
  "VHPhysIO",
  "VHPhysIOKB",
  "QryLogSQLDocV"."SqlTextDoc" AS "TestField",
  "WarningOnly",
  "WDName"
FROM "{{baseDatabase}}"."{{#if vars.tableName}}{{vars.tableName}}{{else}}QryLogV{{/if}}"
INNER JOIN "{{baseDatabase}}"."QryLogSQLDocV" ON "QryLogV"."QueryID" = "QryLogSQLDocV"."QueryID"
{{#if queryLogsVariables.timeRange}}
WHERE "{{baseDatabase}}"."{{#if vars.tableName}}{{vars.tableName}}{{else}}QryLogV{{/if}}"."StartTime"
  BETWEEN TIMESTAMP '{{queryLogsVariables.timeRange.startTimestamp}}' AND TIMESTAMP '{{queryLogsVariables.timeRange.endTimestamp}}'
{{/if}}
{{#if sortingColumns}}
ORDER BY {{#each sortingColumns}}"{{this}}"{{#unless @last}},{{/unless}}{{/each}} ASC NULLS FIRST
{{/if}}