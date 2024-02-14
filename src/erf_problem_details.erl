%%% Copyright 2024 Nomasystems, S.L. http://www.nomasystems.com
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License

%% @doc Module that generates Problem Details representations, based on RFC 9457.
-module(erf_problem_details).

%%% EXTERNAL EXPORTS
-export([
    new/4,
    validation_detail/3
]).

%%% TYPES
-type detail() ::
    validation_detail().

-type validation_detail() :: #{
    schema_path := binary(),
    type := path | query | body,
    reason := binary()
}.

-type t() :: #{
    title := undefined | binary(),
    status := undefined | erf_parser:status_code(),
    detail := undefined | binary(),
    details := undefined | list(detail())
}.

%%% TYPE EXPORTS
-export_type([
    t/0,
    validation_detail/0
]).

%%%-----------------------------------------------------------------------------
%%% EXTERNAL EXPORTS
%%%-----------------------------------------------------------------------------
-spec new(Title, Status, Detail, Errors) -> Resp when
    Title :: undefined | binary(),
    Status :: undefined | erf_parser:status_code(),
    Detail :: undefined | binary(),
    Errors :: undefined | list(detail()),
    Resp :: t().
new(Title, Status, Detail, Details) ->
    #{
        title => Title,
        status => Status,
        detail => Detail,
        details => Details
    }.

-spec validation_detail(Parameter, Type, Reason) -> Resp when
    Parameter :: binary(),
    Type :: path | query | body,
    Reason :: binary(),
    Resp :: validation_detail().
validation_detail(Parameter, Type, Reason) ->
    #{
        schema_path => Parameter,
        type => Type,
        reason => Reason
    }.
