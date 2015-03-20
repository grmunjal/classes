########################
# For reproducibility, make a project directory similar to mine. 
# You only need change the working directory variable path for the rest of the analysis. 

# My project directory contains three folders as follows:
# (1) data   - this folder contains the raw data my hypothetical PI and you shared with me
# (2) output - this folder is where the tables and figures I generate here will go
# (3) code   - this folder contains all the R code presented here combined into one script

########################

#Set working directory for this session. This should be the only thing needing changes 
#assuming the name of the data file is still the same.
setwd("C:\\Users\\uglysweaters\\Desktop\\Comai\\")

#read in the table you shared with me. 
#please modify this if you're using a different file name now.
imprint <- read.table("data\\f_ggg_lc.dat", header = T, sep = "\t")


########################
# Begin Exploratory Analyses
########################

########################
# PEGs
########################

#retreieve naively defined raw PEGs and write to table
#Write a separate table containing GeneIDs for complete set
peg <- imprint[imprint$X.Col_in_ColxPur < imprint$X.Pur_in_ColxPur & 
                 imprint$X.Col.PurxCol > imprint$X.Pur.PurxCol ,]
peg <- na.omit(peg)

write.table(peg, "output\\rawpegs.txt", sep = "\t", quote = F, row.names = F)
write.table(peg[,1], "output\\PEGs-id.txt", 
            sep = "\t", quote = F, row.names = F, col.names = "GeneID")
nrow(peg)

#filter PEGs by using Harada data
#Write filtered PEGs to table 
filterpeg <- peg[peg$micropylar_endosperm != 0 | 
                   peg$peripheral_endosperm != 0 | 
                   peg$chalazal_endosperm != 0, ]

write.table(filterpeg, "output\\PEGs-Haradaconfirmed.txt", 
            sep = "\t", quote = F, row.names = F)
nrow(filterpeg)

##################
# Visualize PEGs
##################

#make an empty data frame with columns for Parent, Contribution, and Hybrid
pegplot <- matrix( nrow = nrow(peg), ncol = 3)
colnames(pegplot) <- c("Parent","Contribution","Hybrid")

#use rounded-up percent contributions from PEGs
pegplot[, 1:3] <- cbind("Col", round(peg[,3],0), "Col x Pur")
pegplot <- rbind(pegplot, cbind("Pur",round(peg[,4],0),"Col x Pur"))
pegplot <- rbind(pegplot, cbind("Col",round(peg[,6],0),"Pur x Col"))
pegplot <- rbind(pegplot, cbind("Pur",round(peg[,7],0),"Pur x Col"))

pegplot <- as.data.frame(pegplot)
pegplot$Contribution <- as.double(as.character(pegplot$Contribution))

library(ggplot2)
p2 <- ggplot(pegplot, aes(factor(Hybrid), Contribution))

#boxplot
pegbox <- p2 + geom_boxplot(aes(fill = factor(Parent)),) +  
  labs(y = "Contribution by Parent (%)", x = "Hybrid", title = "PEGs") +
  theme(legend.title= element_blank(),legend.key = element_rect(fill='NA')) + 
  guides(colour = guide_legend(override.aes = list(size=6))) +
  theme(plot.title = element_text(size=22,lineheight=.2, vjust=2),
        axis.title.x = element_text(size=16, lineheight=4),
        axis.title.y = element_text(size=16, vjust=0.7),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=12))

pegbox

#jitterplot
pegjit <- p2 + geom_jitter(aes(color = factor(Parent)),
                           size=3.5,position = position_jitter(width = .1)) + 
  labs(y = "Contribution by Parent (%)", x ="Hybrid", title = "PEGs") +
  theme(legend.title = element_blank(), legend.key = element_rect(fill='NA')) + 
  guides(colour = guide_legend(override.aes = list(size=6))) +
  theme(plot.title = element_text(size=22,lineheight=.2, vjust=2),
        axis.title.x = element_text(size=16, lineheight=4),
        axis.title.y = element_text(size=16, vjust=0.7),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=12))

pegjit

pdf("output//PEGs.pdf")
pegbox
pegjit
dev.off()


########################
# Retrieve Non-Significant (for 2:1 endosperm expectation) SNPs
########################

#filter for SNPs that are not significantly different at the 95% confidence level
sigimprint <- imprint[imprint$adj_P > 0.05, ]
sigimprint <- sigimprint[sigimprint$SNP.used > 0, ]
sigimprint <- na.omit(sigimprint)

nrow(sigimprint)


##################
# Visualize Non-Significant SNPs
##################

#make an empty data frame with columns for Parent, Contribution, and Hybrid
sigimprintplot <- matrix( nrow = nrow(sigimprint), ncol = 3)
colnames(sigimprintplot) <- c("Parent","Contribution","Hybrid")

#use rounded-up percent contributions from non-significant SNPs
sigimprintplot[, 1:3] <- cbind("Col", round(sigimprint[,3],0), "Col x Pur")
sigimprintplot <- rbind(sigimprintplot, cbind("Pur",round(sigimprint[,4],0),"Col x Pur"))
sigimprintplot <- rbind(sigimprintplot, cbind("Col",round(sigimprint[,6],0),"Pur x Col"))
sigimprintplot <- rbind(sigimprintplot, cbind("Pur",round(sigimprint[,7],0),"Pur x Col"))

sigimprintplot <- as.data.frame(sigimprintplot)
sigimprintplot$Contribution <- as.double(as.character(sigimprintplot$Contribution))

library(ggplot2)
p <- ggplot(sigimprintplot, aes(factor(Hybrid), Contribution))

#boxplot
sigbox <- p + geom_boxplot(aes(fill = factor(Parent)),) +  
              labs(y = "Contribution by Parent (%)", x = "Hybrid", 
                   title = "Non-Significant SNPs") +
              theme(legend.title= element_blank(),legend.key = element_rect(fill='NA')) + 
              guides(colour = guide_legend(override.aes = list(size=6))) +
              theme(plot.title = element_text(size=22,lineheight=.2, vjust=2),
                    axis.title.x = element_text(size=16, lineheight=4),
                    axis.title.y = element_text(size=16, vjust=0.7),
                    axis.text.x = element_text(size=14),
                    axis.text.y = element_text(size=12))

sigbox

#jitterplot
sigjit <- p + geom_jitter(aes(color = factor(Parent)),size=2) + 
          labs(y = "Contribution by Parent (%)", x ="Hybrid", 
               title = "Non-Significant SNPs") +
          theme(legend.title = element_blank(), legend.key = element_rect(fill='NA')) + 
          guides(colour = guide_legend(override.aes = list(size=6))) +
          theme(plot.title = element_text(size=22,lineheight=.2, vjust=2),
                axis.title.x = element_text(size=16, lineheight=4),
                axis.title.y = element_text(size=16, vjust=0.7),
                axis.text.x = element_text(size=14),
                axis.text.y = element_text(size=12))

sigjit


pdf("output//sigimprint.pdf")
sigbox
sigjit
dev.off()


########################
# MEGs
########################

#retreieve naively defined raw MEGs and write to table
meg <- sigimprint[sigimprint$X.Col_in_ColxPur > sigimprint$X.Pur_in_ColxPur & 
                    sigimprint$X.Col.PurxCol < sigimprint$X.Pur.PurxCol,]
meg <- na.omit(meg)
write.table(meg, "output\\rawmegs.txt", sep = "\t", quote = F, row.names = F)
nrow(meg)

#filter MEGs by using Harada data
#Write filtered MEGs to table 
#Write a separate table containing GeneIDs for filtered set
filtermeg <- meg[meg$general_seed_coat<7.5 & 
                   meg$chalazal_seed_coat<7.5 & 
                   meg$embryo<7.5 & 
                   meg$suspensor<7.5,]

filtermeg <- filtermeg[filtermeg$micropylar_endosperm>9 | 
                         filtermeg$peripheral_endosperm>9 | 
                         filtermeg$chalazal_endosperm>9 ,]

write.table(filtermeg, "output\\MEGs-Haradaconfirmed.txt", 
            sep = "\t", quote = F, row.names = F)

write.table(filtermeg[,1], "output\\MEGs-id.txt", 
            sep = "\t", quote = F, row.names = F, col.names = "GeneID")

nrow(filtermeg)


##################
# Visualize MEGs
##################

#make an empty data frame with columns for Parent, Contribution, and Hybrid
megplot <- matrix( nrow = nrow(filtermeg), ncol = 3)
colnames(megplot) <- c("Parent","Contribution","Hybrid")

#use rounded-up percent contributions from PEGs
megplot[, 1:3] <- cbind("Col", round(filtermeg[,3],0), "Col x Pur")
megplot <- rbind(megplot, cbind("Pur",round(filtermeg[,4],0),"Col x Pur"))
megplot <- rbind(megplot, cbind("Col",round(filtermeg[,6],0),"Pur x Col"))
megplot <- rbind(megplot, cbind("Pur",round(filtermeg[,7],0),"Pur x Col"))

megplot <- as.data.frame(megplot)
megplot$Contribution <- as.double(as.character(megplot$Contribution))

library(ggplot2)
p2 <- ggplot(megplot, aes(factor(Hybrid), Contribution))

#boxplot
megbox <- p2 + geom_boxplot(aes(fill = factor(Parent)),) +  
  labs(y = "Contribution by Parent (%)", x = "Hybrid", title = "MEGs") +
  theme(legend.title= element_blank(),legend.key = element_rect(fill='NA')) + 
  guides(colour = guide_legend(override.aes = list(size=6))) +
  theme(plot.title = element_text(size=22,lineheight=.2, vjust=2),
        axis.title.x = element_text(size=16, lineheight=4),
        axis.title.y = element_text(size=16, vjust=0.7),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=12))

megbox

#jitterplot
megjit <- p2 + geom_jitter(aes(color = factor(Parent)),size=3.5,position = position_jitter(width = .1)) + 
  labs(y = "Contribution by Parent (%)", x ="Hybrid", title = "MEGs") +
  theme(legend.title = element_blank(), legend.key = element_rect(fill='NA')) + 
  guides(colour = guide_legend(override.aes = list(size=6))) +
  theme(plot.title = element_text(size=22,lineheight=.2, vjust=2),
        axis.title.x = element_text(size=16, lineheight=4),
        axis.title.y = element_text(size=16, vjust=0.7),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=12))

megjit


pdf("output//MEGs.pdf")
megbox
megjit
dev.off()

comparison <- c(nrow(sigimprint), nrow(peg), nrow(filterpeg), nrow(meg), nrow(filtermeg))
comparison <- as.matrix(comparison)
rownames(comparison) <- c("Non-Significant","PEGs","PEGs confirmed by Harada","MEGs","MEGs confirmed by Harada")
colnames(comparison) <- c("SNPs")
comparison

dev.off()



