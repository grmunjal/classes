#!/usr/bin/env python

i = 0
y = 0

k11 = "GCTACTTTACCATTCTCAGCGAGACGTAAGATCAGGCCAGATCCACCTCG"
k12 = "GTTCCTTTAACATTCTCAGCGAGACGTAAGAGCAGGCCAGATCCACCGCC"
k21 = "GCTCCTTTACCATCCTCAGCGAGACGTAAGATCAGGACAGATCCACCTCG"
k22 = "GCTACTTTACCATCCTCAGCGACACGTAAGATCAGGCCAGATCCACCTCG"
k31 = "GCTACTTTACCATCCTCAGCGAGACGTAAGAGCAGGCCAGATCCACCTCC"
k32 = "GCTACTTTACCATCCTCAGCGAGACGTAGGAGCAGGACAGATCCACCTCG"
old = "GCTCCTTTACCATCCTCAGGGACACGTAAGAGCAGGCCAGACCCACCTCC"

l11 = k11[0]
l12 = k12[0]
l21 = k21[0]
l22 = k22[0]
l31 = k31[0]
l32 = k32[0]
anc = old[0]

while y < len(k11):
    if k11[y] == k12[y] == k21[y] == k22[y] == k31[y] == k32[y]:
        y += 1
    else:
        i += 1
        l11 = l11 + k11[y]
        l12 = l12 + k12[y]
        l21 = l21 + k21[y]
        l22 = l22 + k22[y]
        l31 = l31 + k31[y]
        l32 = l32 + k32[y]
        anc = anc + old[y]
        y += 1

A = l11
B = l12
C = l21
D = l22
E = l31
F = l32

y = 0
AB = 0
AC = 0
AD = 0
AE = 0
AF = 0
BC = 0
BD = 0
BE = 0
BF = 0
CD = 0
CE = 0
CF = 0
DE = 0
DF = 0
EF = 0

while y < len(A):
    if A[y] != B[y]:
        AB += 1
    if A[y] != C[y]:
        AC += 1
    if A[y] != D[y]:
        AD += 1
    if A[y] != E[y]:
        AE += 1
    if A[y] != F[y]:
        AF += 1
    if B[y] != C[y]:
        BC += 1
    if B[y] != D[y]:
        BD += 1
    if B[y] != E[y]:
        BE += 1
    if B[y] != F[y]:
        BF += 1
    if C[y] != D[y]:
        CD += 1
    if C[y] != E[y]:
        CE += 1
    if C[y] != F[y]:
        CF += 1
    if D[y] != E[y]:
        DE += 1
    if D[y] != F[y]:
        DF += 1
    if E[y] != F[y]:
        EF += 1
    else:
        pass
    y += 1

print "AB" + "\t" + str(AB)
print "AC" + "\t" + str(AC)
print "AD" + "\t" + str(AD)
print "AE" + "\t" + str(AE)
print "AF" + "\t" + str(AF)
print "BC" + "\t" + str(BC)
print "BD" + "\t" + str(BD)
print "BE" + "\t" + str(BE)
print "BF" + "\t" + str(BF)
print "CD" + "\t" + str(CD)
print "CE" + "\t" + str(CE)
print "CF" + "\t" + str(CF)
print "DE" + "\t" + str(DE)
print "DF" + "\t" + str(DF)
print "EF" + "\t" + str(EF)
print "total" + "\t" + str(AB+AC+AD+AE+AF+BC+BD+BE+BF+CD+CE+CF+DE+DF+EF)

print "\n"
print "s" + "\t" + str(i)
print "pi" + "\t" + str((AB+AC+AD+AE+AF+BC+BD+BE+BF+CD+CE+CF+DE+DF+EF)/15)

print "\n"
print A
print B
print C
print D
print E
print F
print anc + "\t" + "ancestral"
