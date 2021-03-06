; ModuleID = 'local-array-1.pp.bc'
source_filename = "local-array-1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

; CHECK-LABEL: Bundle
; CHECK: target-endianness = little-endian
; CHECK: target-pointer-size = 64 bits
; CHECK: target-triple = x86_64-apple-macosx10.14.0

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
; CHECK: define [4 x si8]* @.str, align 1, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @.str, [37, 100, 10, 0], align 1
; CHECK: }
; CHECK: }

declare i32 @printf(i8*, ...) #2
; CHECK: declare si32 @ar.libc.printf(si8*, ...)

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main(i32, i8**) #0 !dbg !8 {
  %3 = alloca [10 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.value(metadata i8** %1, metadata !17, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata [10 x i32]* %3, metadata !18, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.value(metadata i32 0, metadata !23, metadata !DIExpression()), !dbg !16
  br label %4, !dbg !24

4:                                                ; preds = %9, %2
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ], !dbg !26
  call void @llvm.dbg.value(metadata i32 %.0, metadata !23, metadata !DIExpression()), !dbg !16
  %5 = icmp slt i32 %.0, 10, !dbg !27
  br i1 %5, label %6, label %11, !dbg !29

6:                                                ; preds = %4
  %7 = sext i32 %.0 to i64, !dbg !30
  %8 = getelementptr inbounds [10 x i32], [10 x i32]* %3, i64 0, i64 %7, !dbg !30
  store i32 %.0, i32* %8, align 4, !dbg !32
  br label %9, !dbg !33

9:                                                ; preds = %6
  %10 = add nsw i32 %.0, 1, !dbg !34
  call void @llvm.dbg.value(metadata i32 %10, metadata !23, metadata !DIExpression()), !dbg !16
  br label %4, !dbg !35, !llvm.loop !36

11:                                               ; preds = %4
  %12 = sub nsw i32 %.0, 1, !dbg !38
  %13 = sext i32 %12 to i64, !dbg !39
  %14 = getelementptr inbounds [10 x i32], [10 x i32]* %3, i64 0, i64 %13, !dbg !39
  %15 = load i32, i32* %14, align 4, !dbg !39
  %16 = getelementptr inbounds [4 x i8], [4 x i8]* @.str, i64 0, i64 0, !dbg !40
  %17 = call i32 (i8*, ...) @printf(i8* %16, i32 %15), !dbg !40
  ret i32 0, !dbg !41
}
; CHECK: define si32 @main(si32 %1, si8** %2) {
; CHECK: #1 !entry successors={#2} {
; CHECK:   [10 x si32]* $3 = allocate [10 x si32], 1, align 16
; CHECK:   si32 %.0 = 0
; CHECK: }
; CHECK: #2 predecessors={#1, #3} successors={#3, #4} {
; CHECK: }
; CHECK: #3 predecessors={#2} successors={#2} {
; CHECK:   %.0 silt 10
; CHECK:   si64 %4 = sext %.0
; CHECK:   si32* %5 = ptrshift $3, 40 * 0, 4 * %4
; CHECK:   store %5, %.0, align 4
; CHECK:   si32 %6 = %.0 sadd.nw 1
; CHECK:   si32 %.0 = %6
; CHECK: }
; CHECK: #4 !exit predecessors={#2} {
; CHECK:   %.0 sige 10
; CHECK:   si32 %7 = %.0 ssub.nw 1
; CHECK:   si64 %8 = sext %7
; CHECK:   si32* %9 = ptrshift $3, 40 * 0, 4 * %8
; CHECK:   si32 %10 = load %9, align 4
; CHECK:   si8* %11 = ptrshift @.str, 4 * 0, 1 * 0
; CHECK:   si32 %12 = call @ar.libc.printf(%11, %10)
; CHECK:   return 0
; CHECK: }
; CHECK: }

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 (tags/RELEASE_1000/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: GNU)
!1 = !DIFile(filename: "local-array-1.c", directory: "/Users/marthaud/ikos/ikos-git/frontend/llvm/test/regression/import/basic_optimization")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 10.0.0 (tags/RELEASE_1000/final)"}
!8 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !9, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !12}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DILocalVariable(name: "argc", arg: 1, scope: !8, file: !1, line: 6, type: !11)
!16 = !DILocation(line: 0, scope: !8)
!17 = !DILocalVariable(name: "argv", arg: 2, scope: !8, file: !1, line: 6, type: !12)
!18 = !DILocalVariable(name: "a", scope: !8, file: !1, line: 8, type: !19)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 320, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 10)
!22 = !DILocation(line: 8, column: 7, scope: !8)
!23 = !DILocalVariable(name: "i", scope: !8, file: !1, line: 7, type: !11)
!24 = !DILocation(line: 9, column: 8, scope: !25)
!25 = distinct !DILexicalBlock(scope: !8, file: !1, line: 9, column: 3)
!26 = !DILocation(line: 0, scope: !25)
!27 = !DILocation(line: 9, column: 17, scope: !28)
!28 = distinct !DILexicalBlock(scope: !25, file: !1, line: 9, column: 3)
!29 = !DILocation(line: 9, column: 3, scope: !25)
!30 = !DILocation(line: 10, column: 5, scope: !31)
!31 = distinct !DILexicalBlock(scope: !28, file: !1, line: 9, column: 28)
!32 = !DILocation(line: 10, column: 10, scope: !31)
!33 = !DILocation(line: 11, column: 3, scope: !31)
!34 = !DILocation(line: 9, column: 24, scope: !28)
!35 = !DILocation(line: 9, column: 3, scope: !28)
!36 = distinct !{!36, !29, !37}
!37 = !DILocation(line: 11, column: 3, scope: !25)
!38 = !DILocation(line: 12, column: 22, scope: !8)
!39 = !DILocation(line: 12, column: 18, scope: !8)
!40 = !DILocation(line: 12, column: 3, scope: !8)
!41 = !DILocation(line: 13, column: 3, scope: !8)
