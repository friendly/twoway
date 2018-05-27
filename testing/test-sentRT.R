# test how to do the ANOVA for the two-way table, including Tukey's test for non-additivity

data(sentRT)
sent.2way <- twoway(sentRT)
sent.df <- as.data.frame(sent.2way)

anova(aov(data ~ row + col, data=sent.df))
anova(aov(data ~ row + col + nonadd, data=sent.df))

sent.mod1 <- lm(data ~ row + col, data=sent.df)
sent.mod2 <- lm(data ~ row + col + nonadd, data=sent.df)

anova(sent.mod1)
anova(sent.mod2)
# test non-add
anova(sent.mod1, sent.mod2)


sent.mat <- as.matrix(sentRT)
names(dimnames(sent.mat)) <- c("Subject", "Sentence")
sentm.2way <- twoway(sent.mat)
sentm.2way$varNames

sentm.long <- to_long(sent.mat, response="RT")

twoway(RT ~ Subject + Sentence, data=sentm.long)

