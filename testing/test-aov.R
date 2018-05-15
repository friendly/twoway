# testing how to do a twoway.anova method

data(sentRT)
sent.2way <- twoway(sentRT)
sent.df <- as.data.frame(sent.2way)

aov1 <- anova(mod1 <- aov(data ~ row + col, data=sent.df))
aov2 <- anova(mod2 <- aov(data ~ row + col + nonadd, data=sent.df))
aov3 <- anova(mod1, mod2)



sent.mod1 <- lm(data ~ row + col, data=sent.df)
sent.mod2 <- lm(data ~ row + col + nonadd, data=sent.df)

anova(sent.mod1)
anova(sent.mod2)
# test non-add
anova(sent.mod1, sent.mod2)

str(aov1)
rownames(aov1)
