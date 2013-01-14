// RUN: rm -rf %t
// RUN: %clang_cc1 -emit-llvm -o - -fmodule-cache-path %t -fmodules -F %S/Inputs -I %S/Inputs %s | FileCheck %s

@import autolink.sub2;

int f() {
  return autolink_sub2();
}

@import autolink;

int g() {
  return autolink;
}

// CHECK: !llvm.link.libraries = !{![[AUTOLINK:[0-9]+]], ![[AUTOLINK_FRAMEWORK:[0-9]+]]}
// CHECK: ![[AUTOLINK]] = metadata !{metadata !"autolink", i1 false}
// CHECK: ![[AUTOLINK_FRAMEWORK]] = metadata !{metadata !"autolink_framework", i1 true}