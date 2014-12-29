#!/usr/bin/env python
import sys
from math import sin, cos, atan, sqrt, pow

def spiral(segments_number):
    alphas = []

    for i in xrange (0, segments_number):
        alphas.append(float(i) / (segments_number - 1))

    polyline_text = ''
    polyline_text += ','.join(map(lambda alpha: 'c({0},angle,d00,d01)'.format(alpha), alphas))
    polyline_text += ',' + ','.join(map(lambda alpha: 'c({0},angle,d10,d11)'.format(alpha), reversed(alphas)))
    print '''
module magic_spiral_{segments_number}(d00, d01, d10, d11, height, angle) {{
    function p(phi,r) = [cos(phi)*r, sin(phi)*r];
    function c(alpha, angle, d1, d2) = p(angle * alpha, (d1 * (1.0 - alpha) + d2 * alpha) / 2);

    linear_extrude(height=height)
        polygon([{polyline_text}]);
}}
'''.format(
        polyline_text=polyline_text,
        segments_number=segments_number
    )

def main():
    segments_number = 16 
    while segments_number <= 4096:
        spiral(segments_number)
        segments_number *= 2
        
if __name__ == '__main__':
    main()
