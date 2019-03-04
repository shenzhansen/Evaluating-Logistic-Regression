##### E6690 Final project Codes
##### Graphical Methods For Assessing Logistic Regression
##### (Based on Haberman's survival data)
##### Authors: Zhansen Shen(zs2390), Yuting Wang(yw3167)

##### Note: local mean deviance and empirical probability 
##### are implemented in our own codes, while others have 
##### some built in functions


##### LOCAL MEAN DEVIANCE PLOT








##### EMPIRICAL PROBABILITY PLOT


input = read.table("C:/Users/szs96/Desktop/haberman.data",header=T, 
                   sep=",")
mydatanew = transform(input, X1.1 = -X1.1+2)
numiter = 25
numignore = 2;
sorted_residuals = matrix(, nrow = 305, ncol = numiter)
#glm.fit <- glm(X1.1 ~ X1 + X64 +X30, data = mydatanew)

glm.fit <- glm(X1.1 ~ X64 +I(log((1+X1)^(-1)))+I(X30*X64)+I(X30^2)+X30 + I(X30^3), data = mydatanew)
               
               
pfit = fitted.values(glm.fit)
sortedr = sort(ysample-pfit,decreasing = FALSE)
sorted_residuals[, 1] <- sortedr

pfitnew = seq(from = -2.7, to = 1.3, length.out = 305)
ysample = seq(from = -2.7, to = 1.3, length.out = 305)
calcresiduals = seq(from = -2.7, to = 1.3, length.out = 305)


for (t in 2:numiter){
 
for (i in 1:305){
  pfitnew[i] = pfit[i]
  if (pfit[i]>1){
    pfitnew[i] = 1 
  }
  if (pfit[i]<0){
    pfitnew[i] = 0 
  }
  
}
  
for (i in 1:305){
  ysample[i] = rbinom(1,1,pfitnew[i])
}

mydatanew$ysample = ysample

#glm.fit <- glm(ysample ~ X1 + X64 +X30, data = mydatanew)

glm.fit <- glm(ysample ~ X64 +I(log((1+X1)^(-1)))+I(X30*X64)+I(X30^2)+X30 + I(X30^3), data = mydatanew)


pfit = fitted.values(glm.fit)

#calcresiduals = ysample - pfit 

#resones = seq(from = -2.7, to = 1.3, length.out = sum(ysample))
#reszeros = seq(from = -2.7, to = 1.3, length.out = 305-sum(ysample))

#r1 = 1
#r2 = 1
#for (i in 1:305){
#  if(ysample[i]>0){
#    resones[r1] = calcresiduals[i]
#    r1 = r1+1
#  }
#  if(ysample[i]<=0){
#    reszeros[r2]= calcresiduals[i]
#    r2 = r2+1
#  }
#}

#sortedr1 = sort(reszeros,decreasing = FALSE)
#sortedr2 = sort(resones,decreasing = FALSE)

sortedr = sort(ysample-pfit,decreasing = FALSE)

#sortedr = c(sortedr1,sortedr2)

sorted_residuals[, t] <- sortedr


}

median_residuals = seq(from = 0, to = 0.1, length.out = 305)
for (i in 1:305){
  median_residuals[i] = median(sorted_residuals[i,])
}

upperbounds = seq(from = 0, to = 0.1, length.out = 305)
lowerbounds = seq(from = 0, to = 0.1, length.out = 305)
k = seq(from = 0, to = 0.1, length.out = numiter)
for (i in 1:305){
  k = sort(sorted_residuals[i,],decreasing = FALSE)
  upperbounds[i] = k[numiter-numignore]
  lowerbounds[i] = k[numignore+1]
  
}

plot(median_residuals,sorted_residuals[,25],main="Empirical Probability plot", xlab="Median Residual", ylab="Residual", xlim=c(-1, 1), ylim=c(-1, 1))
lines(median_residuals, upperbounds,col = 'red')
lines(median_residuals, lowerbounds,col = 'red')
abline(0,1,col = 'blue')


#####PARTIAL RESIDUAL PLOTS

library(car)

input = read.table("C:/Users/szs96/Desktop/haberman.data",header=T, 
                   sep=",")
mydatanew = transform(input, X1.1 = -X1.1+2)

#glm.fit <- glm(X1.1 ~ X64 +I(log(1/(X1+1)))+I(X30*X64)+I(X30^2)+X30 + I(X30^3), data = mydatanew)

glm.fit <- glm(X1.1 ~ X30+X64+I((X1+1)^(-1)), data = mydatanew)

crPlots(glm.fit,layout = c(1,1))


######Testing new algorithms

######RIDGE, LASSO, LIKELIHOOD RATIO AND PSEUDO R2

library(glmnet)
input = read.table("C:/Users/szs96/Desktop/haberman.data",header=T, 
                   sep=",")
mydatanew = transform(input, X1.1 = -X1.1+2)

mydatanew$X302 = mydatanew$X30 * mydatanew$X30
mydatanew$X303 = mydatanew$X302 * mydatanew$X30
mydatanew$X30X64 = mydatanew$X30 * mydatanew$X64
mydatanew$X1log = log(1+mydatanew$X1)

mydatanew <- mydatanew[,c(1,2,3,5,6,7,8,4)]

# ridge and lasso


X = mydatanew[,1:7]
Y = mydatanew[,8]

X = data.matrix(X, rownames.force = NA)



glm.fit = glmnet(X,Y,family = "binomial",alpha = 0) #alpha = 0 or 1, ridge/lasso
summary(glm.fit)
#plot(glm.fit,label = TRUE, ylim = c(-0.5,0.2))
plot(glm.fit,label = TRUE)

# Below are analysis from statistical perspective: no graphs plotted

# likelihood ratio test: run and see log likelihood and p value to decide best one

model1 <- glm(X1.1 ~ X30+X64+X1, data = mydatanew, family = "binomial")
model2 <- glm(X1.1 ~ X64 +I(log(1/(X1+1)))+I(X30*X64)+I(X30^2)+X30 + I(X30^3), data = mydatanew)
model3 <- glm(X1.1 ~ X64 +I(X30*X64)+I(X30^2)+X30 + I(X30^3), data = mydatanew)
model4 <- glm(X1.1 ~ X64 +I(X30^2)+X30 + I(X30^3), data = mydatanew)
model5 <- glm(X1.1 ~ X64 +X30 + I(X30^3), data = mydatanew)
model6 <- glm(X1.1 ~ X64 +I(log((X1+1)))+I(X30^2)+X30 + I(X30^3), data = mydatanew)
model7 <- glm(X1.1 ~ X64 +X30 , data = mydatanew)

library(lmtest)
lrtest(model1,model2,model3,model4,model5,model6,model7)

# psuedo R squared: run and see McFadden. 
# Similar to R2 statistic in linear regression. Higher means better. 


library(pscl)
pR2(model1)
pR2(model2)
pR2(model3)
pR2(model4)
pR2(model5)
pR2(model6)
pR2(model7)



