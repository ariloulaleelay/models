#!/usr/bin/env python3
from math import atan, cos, pi, sin, sqrt, tan  # noqa

from yaost import Project, Vector, cylinder, get_logger, hull, union

logger = get_logger(__name__)

p = Project('table_hook')
inf = 1000
tol = 0.01


def make_line(points, height, chamfer_top=0, chamfer_bottom=0):
    chunks = []
    for p0, p1 in zip(points, points[1:]):
        chunks.append(
            hull(
                cylinder(
                    d=p0.z,
                    h=height,
                    chamfer_top=chamfer_top,
                    chamfer_bottom=chamfer_bottom,
                ).t(p0.x, p0.y),
                cylinder(
                    d=p1.z,
                    h=height,
                    chamfer_top=chamfer_top,
                    chamfer_bottom=chamfer_bottom,
                ).t(p1.x, p1.y),
            )
        )
    return union(*chunks)


@p.add_part
def table_hook():
    top_length = 50
    table_height = 26
    thin = 4
    medium = 5
    thick = 10
    r1 = 10
    sector_angle = 70
    hook_angle = 260
    hook_radius = 10
    segments = 64
    width = 15

    path = [
        Vector(0, thin / 2, thin),
        Vector(top_length, thick / 2, thick),
        Vector(top_length, -table_height, thick),
    ]
    for seg in range(1, segments):
        thickness = thick
        angle = sector_angle * seg / segments
        pp = Vector(r1, 0, thickness).rz(-angle).t(top_length - r1, -table_height, 0)
        path.append(pp)

    for seg in range(1, segments + 1):
        thickness_alpha = (seg) / (segments)
        thickness = thick * (1.0 - thickness_alpha) + thickness_alpha * medium

        angle = hook_angle * seg / segments
        r = hook_radius + thick
        pp = Vector(0, r, thickness).rz(angle).t(r, -table_height - r1 - r, 0)
        path.append(pp)

    result = make_line(path, width, chamfer_top=1, chamfer_bottom=1)
    return result


if __name__ == '__main__':
    p.run()
