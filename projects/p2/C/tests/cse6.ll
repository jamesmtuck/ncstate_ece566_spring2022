; ModuleID = 'cse6'
; CHECK-LABEL: source_filename = "cse6"
source_filename = "cse6"

; CHECK-LABEL: i32 @cse6(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5)
define i32 @cse6(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5) {
; CHECK-NEXT: BB
; CHECK-NEXT: alloca
; CHECK-NEXT: alloca
; CHECK-NEXT: and
; CHECK-NEXT: store
; CHECK-NEXT: load
; CHECK-NEXT: store
; CHECK-NEXT: icmp sge
; CHECK-NEXT: br i1
; CHECK-EMPTY:
BB:
  %A = alloca i32, align 4
  store i32 %3, i32* %A, align 4
  %A1 = alloca i16, align 2
  %L = load i32, i32* %A, align 4
  %6 = and i32 %L, 77033
  %7 = and i32 %6, 77033
  store i32 %7, i32* %A, align 4
  %8 = and i32 %6, 77033
  %L2 = load i16, i16* %A1, align 2
  store i32 %8, i32* %A, align 4
  store i32 77033, i32* %A, align 4
  %Cmp = icmp sge i32 %8, %L
  br i1 %Cmp, label %BB3, label %BB4

; CHECK-LABEL: BB3:
; CHECK-NEXT: load
; CHECK-NEXT: srem
; CHECK-NEXT: or
; CHECK-NEXT: store
; CHECK-NEXT: br
; CHECK-EMPTY:
BB3:                                              ; preds = %BB
  %L6 = load i8, i8* %0, align 1
  %9 = srem i8 %L6, %5
  %10 = or i8 %L6, %9
  store i8 %10, i8* %0, align 1
  br label %BB5

; CHECK-LABEL: BB4:
; CHECK-NEXT: load
; CHECK-NEXT: sdiv
; CHECK-NEXT: srem
; CHECK-NEXT: store
; CHECK-NEXT: br label
BB4:                                              ; preds = %BB
  %L7 = load i32, i32* %A, align 4
  %11 = sdiv i32 %L7, %3
  %12 = srem i32 %L7, %11
  store i32 %12, i32* %A, align 4
  br label %BB5

; CHECK-LABEL: BB5:
; CHECK-NEXT: br label
BB5:                                              ; preds = %BB4, %BB3
  br label %BB8

; CHECK-LABEL: BB8:
; CHECK-NEXT: load
; CHECK-NEXT: icmp ne
; CHECK-NEXT: br i1
BB8:                                              ; preds = %BB9, %BB5
  %L11 = load i8, i8* %0, align 1
  %Cmp12 = icmp ne i8 %L11, %5
  br i1 %Cmp12, label %BB9, label %BB10

; CHECK-LABEL: BB9:
; CHECK-NEXT: load
; CHECK-NEXT: store
; CHECK-NEXT: br label
BB9:                                              ; preds = %BB8
  %L13 = load i32, i32* %A, align 4
  %13 = and i32 %L13, %L13
  %14 = sub i32 %L13, %13
  store i32 %14, i32* %A, align 4
  br label %BB8

; CHECK-LABEL: BB10:
; CHECK-NEXT: store
; CHECK-NEXT: ret i32
BB10:                                             ; preds = %BB8
  store i32 %L, i32* %A, align 4
  ret i32 %L
}
