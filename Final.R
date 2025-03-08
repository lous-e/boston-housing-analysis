#Utilities
set.seed(0)
library(ggplot2)
library(corrplot)
library(caret)

#Loading the dataset
df <- boston.housing.dataset[, -1]
n <- nrow(df)

#dropping B
df <- df[, -12]

#Transformations
df$logCRIM <- log(df$CRIM)
df$logINDUS <- log(df$INDUS)
df$RAD.t <- ifelse(df$RAD == 24, 1, 0)
df$logDIS <- log(df$DIS)
df$logLSTAT <- log(df$LSTAT)

#Correlations
cor_matrix <- cor(df)
correlations <- cor(df)
correlations[correlations < 0.8 & correlations > 0 | correlations > -0.8 & correlations < 0 | correlations == 1] <- ""
corrplot(cor_matrix)

#Training-test split
indices <- sample(1:n, size = n*0.2)
df_test <- df[indices,]
df_train <- df[-indices,]

#helper functions for mse
err <- function (y_pred, y) mean((y - y_pred)^2)
get_test_mse <- function (mod) err(predict(mod, df_test), df_test$MEDV)
get_train_mse <- function (mod) mean(mod$residuals^2)

plot(df$logCRIM, df$RAD.t)
#NOX excluded from every model (since correlated with logDIS)

#Model 0
mod_0 <- lm(MEDV ~ .-logCRIM -logINDUS - logDIS - logLSTAT - RAD.t - NOX, data = df_train)
summary(mod_0)
mod_0_R2 <- summary(mod_0)$adj.r.squared
epsilon_mod_0 <- mod_0$residuals
hist(epsilon_mod_0)
boxplot(epsilon_mod_0)
qqnorm(epsilon_mod_0)
qqline(epsilon_mod_0)
plot(mod_0$fitted.values,epsilon_mod_0)
abline(h = 0, lty = 2)

mse_0_test <- get_test_mse(mod_0)
mse_0_train <- get_train_mse(mod_0)

#Model 1
mod_1 <- lm(MEDV ~ .-logCRIM -logINDUS - logDIS - logLSTAT - RAD.t - INDUS - AGE - NOX, data = df_train)
summary(mod_1)
mod_1_R2 <- summary(mod_1)$adj.r.squared
epsilon_mod_1 <- mod_1$residuals
hist(epsilon_mod_1)
boxplot(epsilon_mod_1)
qqnorm(epsilon_mod_1)
qqline(epsilon_mod_1)
plot(mod_1$fitted.values,epsilon_mod_1)
abline(h = 0, lty = 2)

mse_1_train <- get_train_mse(mod_1)
mse_1_test <- get_test_mse(mod_1)

# #Model 2
mod_2 <- lm(MEDV ~ .-CRIM -INDUS - DIS - LSTAT - RAD - NOX - logCRIM, data = df_train)
summary(mod_2)
mod_2_R2 <- summary(mod_2)$adj.r.squared
epsilon_mod_2 <- mod_2$residuals
hist(epsilon_mod_2)
boxplot(epsilon_mod_2)
qqnorm(epsilon_mod_2)
qqline(epsilon_mod_2)
plot(mod_2$fitted.values,epsilon_mod_2)
abline(h = 0, lty = 2)

mse_2_train <- get_train_mse(mod_2)
mse_2_test <- get_test_mse(mod_2)

#Model 3
mod_3 <- lm(MEDV ~ .-CRIM -INDUS - DIS - LSTAT - RAD - ZN - AGE - TAX - logCRIM - RAD.t - NOX, data = df_train)
summary(mod_3)
mod_3_R2 <- summary(mod_3)$adj.r.squared
epsilon_mod_3 <- mod_3$residuals
hist(epsilon_mod_3)
boxplot(epsilon_mod_3)
qqnorm(epsilon_mod_3)
qqline(epsilon_mod_3)
plot(mod_3$fitted.values,epsilon_mod_3)
abline(h = 0, lty = 2)

mse_3_train <- get_train_mse(mod_3)
mse_3_test <- get_test_mse(mod_3)

plot(c(mse_0_test, mse_1_test, mse_2_test, mse_3_test))

mse_train <- data.frame(error=c(mse_0_train, mse_1_train, mse_2_train, mse_3_train), model=c(1, 2, 3, 4))
mse_test <- data.frame(error=c(mse_0_test, mse_1_test, mse_2_test, mse_3_test), model=c(1, 2, 3, 4))

mse_train$year <- ordered(mse_train$model, levels=c(1, 2, 3, 4))
ggplot(mse_train, aes(x=factor(model), y=error, group=1)) + geom_line() + geom_point()
ggplot(mse_test, aes(x=factor(model), y=error, group=2)) + geom_line() + geom_point()

mse_test$year <- ordered(mse_test$model, levels=c(1, 2, 3, 4))
ggplot(mse_test, aes(x=factor(model), y=error, group=1)) + geom_line() + geom_point()