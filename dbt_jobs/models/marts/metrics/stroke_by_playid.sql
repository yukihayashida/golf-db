select *
from {{ metrics.calculate(
    metric('total_stroke'),
    grain='year',
    dimensions=['playid'],
    where="total_stroke > 0"
) }}
