# Copyright (c) 2017 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#
#


ifndef os_name
  # Windows sets environment variable OS; for other systems, ask uname
  ifeq ($(OS),)
    OS:=$(shell uname)
    ifeq ($(OS),)
      $(error "Cannot detect operating system")
    endif
    export os_name=$(OS)
  endif

  ifeq ($(OS), Windows_NT)
    export os_name=windows
  endif
  ifeq ($(OS), Linux)
    export os_name=linux
  endif
  ifeq ($(OS), Darwin)
    export os_name=macos
  endif
endif

export compiler?=clang
export arch?=ia32
export target?=android

ifeq (ia32,$(arch))
    APP_ABI:=x86
else ifeq (intel64,$(arch))
    APP_ABI:=x86_64
else ifeq (arm,$(arch))
    APP_ABI:=armeabi-v7a
else ifeq (arm64,$(arch))
    APP_ABI:=arm64-v8a
else
    APP_ABI:=$(arch)
endif

APP_PLATFORM:=android-21
ifneq ("","$(api_version)")
    APP_PLATFORM:=$(api_version)
endif

ifeq (clang,$(compiler))
    NDK_TOOLCHAIN_VERSION:=clang
    APP_STL:=c++_shared
else
    NDK_TOOLCHAIN_VERSION:=4.9
endif
