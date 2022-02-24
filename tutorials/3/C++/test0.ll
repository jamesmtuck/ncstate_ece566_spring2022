; ModuleID = 'test0.c'
source_filename = "test0.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

%struct.X = type { i32, i32, double }

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.X, align 8
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %4 = getelementptr inbounds %struct.X, %struct.X* %2, i32 0, i32 0
  store i32 5, i32* %4, align 8
  %5 = getelementptr inbounds %struct.X, %struct.X* %2, i32 0, i32 1
  store i32 10, i32* %5, align 4
  %6 = getelementptr inbounds %struct.X, %struct.X* %2, i32 0, i32 0
  store i32 25, i32* %6, align 8
  %7 = getelementptr inbounds %struct.X, %struct.X* %2, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp sgt i32 %8, 100
  br i1 %9, label %10, label %14

10:                                               ; preds = %0
  %11 = getelementptr inbounds %struct.X, %struct.X* %2, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = sub nsw i32 %12, 2
  store i32 %13, i32* %11, align 8
  br label %14

14:                                               ; preds = %10, %0
  %15 = getelementptr inbounds %struct.X, %struct.X* %2, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  store i32 %16, i32* %3, align 4
  ret i32 0
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 1]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 12.0.5 (clang-1205.0.22.11)"}
