exports = module.exports = class GrayScott
  constructor: (@width, @height) ->
    size = @width * @height
    @u = new Float64Array(size)
    @v = new Float64Array(size)
    @uu = new Float64Array(size)
    @vv = new Float64Array(size)


    @reset()
    @setCoefficients(0.023, 0.077, 0.16, 0.08)

  reset: ->
    for i in [0..@uu.length - 1] by 1
      @uu[i] = 1.0
      @vv[i] = 0.0
      @u[i] = 0.0
      @v[i] = 0.0

  setCoefficients: (@f, @k, @dU, @dV) ->

  getKCoeffAt: (x, y) ->
    if y % 2
      @k + Math.random() / 100000
    else
      @k - 0.0005

  getFCoeffAt: (x, y) ->
    if x % 2
      @f + Math.random() / 100000
    else
      @f - 0.0005


  clip: (a, min, max) ->
    if a < min
      min
    else if a > max
      max
    else
      a

  setRect: (x, y, w, h) ->
    mix = @.clip(x - w / 2, 0, @width);
    max = @.clip(x + w / 2, 0, @width);
    miy = @.clip(y - h / 2, 0, @height);
    may = @.clip(y + h / 2, 0, @height);
    for yy in [miy..may] by 1
      for xx in [mix..max] by 1
        idx = yy * @width + xx;
        @uu[idx] = @uu[idx] ||  0.5
        @vv[idx] = @vv[idx] || 0.25
    null

  max: (a, b)->
    if (b < a) then a else  b

  update: (t) ->
    t = @clip(t || 1, 0, 1)
    w1 = @width - 1
    h1 = @height - 1

    for y in [1..h1 - 1] by 1
      for x in [1..w1 - 1] by 1

        idx = y * @width + x
        top = idx - @width
        bottom = idx + @width
        left = idx - 1
        right = idx + 1
        currF = @getFCoeffAt x, y
        currK = @getKCoeffAt x, y
        currU = @uu[idx]
        currV = @vv[idx]
        d2 = currU * currV * currV
        @u[idx] = @max(0,
          currU + t * ((@dU * ((@uu[right] + @uu[left] + @uu[bottom] + @uu[top]) - 4 * currU) - d2) + currF * (1 - currU)))

        @v[idx] = @max(0,
          currV + t * ((@dV * ((@vv[right] + @vv[left] + @vv[bottom] + @vv[top]) - 4 * currV) + d2) - currK * currV))

    @uu = new Float64Array(@u)
    @vv = new Float64Array(@v)
    null

