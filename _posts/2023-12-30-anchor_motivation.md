---
layout: post
title: "Motivating example for the study of anchor acceleration"
date: 2023-12-30
background: ''
katex: True
---

In our paper [**Continuous-time Analysis of Anchor Acceleration**](https://openreview.net/forum?id=rN99gLCBe4&referrer=%5BAuthor%20Console%5D(%2Fgroup%3Fid%3DNeurIPS.cc%2F2023%2FConference%2FAuthors%23your-submissions)) 
we consider the problem of minimizing operator norm of monotone operator $$\mathbb{A}$$. 
Solving minimax problem of a convex-concave function is one of the useful application for this problem. 
Consider the problem

$$
  \text{minimize}_{x\in\mathbb{R}^n} \text{maximize}_{y\in\mathbb{R}^m} \, L(x,y)
$$

where $$L\colon\mathbb{R}^n\times\mathbb{R}^m \to \mathbb{R}$$ is a convex-concave function. 
Then for saddle differential defined as

$$
\mathbb{A}(x,y) 
= \begin{pmatrix} \nabla_x L(x,y) \\ -\nabla_y L(x,y) \end{pmatrix},
$$

zero of $$\mathbb{A}$$ is a saddle point, and so is the solution of the previous minimax problem. 
Therefore the minimax problem reduces to the minimization problem

$$
  \text{minimize}_{(x,y)\in\mathbb{R}^{n+m}}  \, \| \mathbb{A}(x,y) \|^2.
$$

As a simple motivating example, let's consider $$L\colon \mathbb{R} \times \mathbb{R} \to \mathbb{R}$$ defined as 

$$
L(x,y)=xy.
$$

Then the saddle operator becomes

$$
\mathbb{A}(x,y) 
= \begin{pmatrix} \nabla_x L(x,y) \\ -\nabla_y L(x,y) \end{pmatrix}
= \begin{pmatrix} y \\ -x \end{pmatrix}
= \begin{pmatrix} 0 & 1 \\ -1 & 0 \end{pmatrix} \begin{pmatrix} x \\ y \end{pmatrix} ,
$$

so $$\mathbb{A} = \begin{pmatrix} 0 & 1 \\ -1 & 0 \end{pmatrix}$$. 
To find the zero of $$\mathbb{A}$$, gradient descent ascent (GDA) is the simplest method we can try. 
That is, considering gradient descent to $$x$$ and considering gradient ascent to $$y$$, as we're considering minimization for $$x$$ and maximization for $$y$$. 
In terms of $$\mathbb{A}$$, such method with stepsize $$h>0$$ can be written as

<!-- $$
(x_{k+1}, y_{k+1}) = (x_{k}, y_{k}) - h \mathbb{A} (x_{k}, y_{k}).
$$ -->

$$
\begin{pmatrix} x_{k+1} \\ y_{k+1} \end{pmatrix}  
= \begin{pmatrix} x_{k} \\ y_{k} \end{pmatrix} 
- h \mathbb{A} \begin{pmatrix} x_{k} \\ y_{k} \end{pmatrix}.
$$

However, this method does not converge. 
The continuous model shares the similar behavior and its simulation gives an intuitive understanding. 
The continuous counterpart of GDA is

<!-- $$
 (\dot{X}(t), \dot{Y}(t)) = - \mathbb{A} (X(t), Y(t)),
$$ -->

$$
 \begin{pmatrix} \dot{X} \\ \dot{Y} \end{pmatrix} 
 = - \mathbb{A} \begin{pmatrix} X \\ Y \end{pmatrix},
$$

<!-- and the simulation for this dynamics with initial value $$(1,0)$$ is as follows. -->
and the simulation for this dynamics with initial value $$ \begin{pmatrix} X_0 \\ Y_0 \end{pmatrix} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$$ is as follows.


<div style="text-align:center;">
  <img src="/img/posts/without_anchor.gif" alt="Local GIF" width="360" height="366">
</div>

We see the flow becomes rotation and does not converge to the zero of $$\mathbb{A} = \begin{pmatrix} 0 & 1 \\ -1 & 0 \end{pmatrix}$$, the origin. 
GDA shares the similar behavior of the rotation and does not converge. (To add some detail, GDA's rotation radius gradually increases.) 

However, if we put an **anchor**, it converges. 
Consider an ODE with anchor

<!-- $$
 (\dot{X}(t), \dot{Y}(t)) = - \mathbb{A} (X(t), Y(t)) - \frac{1}{t} \left( (X(t), Y(t)) - (X_0, Y_0)  \right) ,
$$ -->

$$
 \begin{pmatrix} \dot{X} \\ \dot{Y} \end{pmatrix}  
 = - \mathbb{A} \begin{pmatrix} X \\ Y \end{pmatrix} 
  - \frac{1}{t} \left( \begin{pmatrix} X \\ Y \end{pmatrix}
  - \begin{pmatrix} X_0 \\ Y_0 \end{pmatrix}  \right) .
$$

In the above equation, we call $$\begin{pmatrix} X_0 \\ Y_0 \end{pmatrix}$$ as an anchor. 
The role of the anchor is captured in the below simulation. 

<div style="text-align:center;">
  <img src="/img/posts/anchor_animation.gif" alt="Local GIF" width="632" height="312">
</div>

<!-- The term $$\begin{pmatrix} X \\ Y \end{pmatrix} - \begin{pmatrix} X_0 \\ Y_0 \end{pmatrix}$$ corresponds to the red line segment in the simulation. 
As we can see in the simulation, the flow is dragged by the anchor and converges to the solution.  -->
Here we set the anchor as $$\begin{pmatrix} X_0 \\ Y_0 \end{pmatrix} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$$. 
The term $$\begin{pmatrix} X \\ Y \end{pmatrix} - \begin{pmatrix} X_0 \\ Y_0 \end{pmatrix}$$ corresponds to the red line segment in the animation, and the line segment pulls the flow like a rope is typed. 
As we can see in the simulation, such dragging makes contraction to the dynamics and gives convergence. 

However, note $$\frac{1}{t}$$ is multiplied to the "rope" term, $$\begin{pmatrix} X \\ Y \end{pmatrix} - \begin{pmatrix} X_0 \\ Y_0 \end{pmatrix}$$. 
We call such coefficient and the anchor coefficient. 
<!-- As $$\lim_{t\to\infty}\frac{1}{t}=0$$, we see such dragging eventually vanish.  -->
As $$\lim_{t\to\infty}\frac{1}{t}=0$$, we see the anchor coefficient eventually vanishes. 
This makes sense, because our goal is the optimal point (zero of $$\mathbb{A}$$) not the anchor, 
but if the dragging to the anchor remains to the end, it will bother the convergence to the optimal. 
Thus the anchor coefficient should vanish, but if it vanishes too fast, the dynamics will behave similar with the one without anchor, which does not converge. 
Then a natural question arises,

<p style="text-align:center;"><em>"how fast should the anchor coefficient vanish to give the best convergence?"</em></p>


This was the one of the motivation behind our work  [**Continuous-time Analysis of Anchor Acceleration**](https://openreview.net/forum?id=rN99gLCBe4&referrer=%5BAuthor%20Console%5D(%2Fgroup%3Fid%3DNeurIPS.cc%2F2023%2FConference%2FAuthors%23your-submissions)). 
We put an answer to this question in **Section 3**.

<!-- <div style="text-align:center;">
  <video width="505.6" height="249.6" controls>
    <source src="/img/posts/anchor_animation.mp4" type="video/mp4">
    Your browser does not support the video tag.
  </video>
</div> -->

