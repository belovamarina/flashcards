class SuperMemo2
  def initialize(card, quality = 4)
    @quality = quality.to_i
    @e_factor = card.e_factor
    @attempts = card.success_reviews
    @interval = card.interval
  end

  def remember_card
    update_e_factor
    increase_interval

    { review_date: Date.today + @interval,
      interval: @interval,
      success_reviews: @attempts,
      e_factor: @e_factor }
  end

  # If the quality response was lower than 3 then start repetitions for the item from the beginning without changing the E-Factor

  def forgot_card
    { review_date: Date.today + 1, interval: 0, success_reviews: 0 }
  end

  private

  # Repeat items using the following intervals:
  # I(1):=1
  # I(2):=6
  # for n>2: I(n):=I(n-1)*EF

  def increase_interval
    @interval = if @attempts.zero?
                  1
                elsif @attempts == 1
                  6
                else
                  (@interval * @e_factor).to_i
                end

    increase_attempts
  end

  def increase_attempts
    @attempts += 1
  end

  # If EF is less than 1.3 then let EF be 1.3.
  def update_e_factor
    ef = @e_factor + (0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02))
    @e_factor = ef < 1.3 ? 1.3 : ef
  end
end
