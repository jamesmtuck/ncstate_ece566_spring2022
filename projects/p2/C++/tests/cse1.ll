; ModuleID = 'cse1'
; CHECK-LABEL: source_filename = "cse1"
source_filename = "cse1"

; CHECK-LABEL: @cse1(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5)
define i32 @cse1(i8* %0, i32* %1, i64* %2, i32 %3, i64 %4, i8 %5) {
; CHECK-NEXT: BB
; CHECK-NEXT: alloca
; CHECK-NEXT: alloca
; CHECK-NEXT: alloca
; CHECK-NEXT: alloca
; CHECK-NEXT: store
; CHECK-NEXT: store
; CHECK-NEXT: load
; CHECK-NEXT: load
; CHECK-NEXT: lshr
; CHECK-NEXT: store
; CHECK-NEXT: store
; CHECK-NEXT: ret i32
BB:
  %A = alloca i32, align 4
  %A1 = alloca i32, align 4
  %A2 = alloca i32, align 4
  %A3 = alloca i32, align 4
  store i32 %3, i32* %A, align 4
  store i32 %3, i32* %A1, align 4
  %L = load i32, i32* %A, align 4
  %L4 = load i32, i32* %A1, align 4
  %B = lshr i32 %L, %L4
  %6 = lshr i32 %L, %L4
  store i32 %6, i32* %A2, align 4
  store i32 %B, i32* %A3, align 4
  ret i32 %3
}
