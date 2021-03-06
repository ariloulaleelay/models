// $fn = 64;
// каркас и крепление фонаря
module MainRing() { 
  difference() {
    difference() {
      cylinder(h = 20, r = 30);
      cylinder(h = 20, r = 14);
      translate([9,-6.5,0])
        cube([10,13,20]);  
      intersection() {
        cylinder(h = 20, r = 15);
        translate([-8, -20, 0])
          cube([16, 40, 20]);  
      }
    }
    // пазы для венгерки на фонарь
    rotate([0, 0, 195])
      translate([27, -1.5, 0])
        cube([3, 3, 20]);  
    rotate([0, 0, 165])
      translate([27, -1.5, 0])
        cube([3, 3, 20]);  
  }
};

// круглый паз
module CurvedSlot() {
  intersection() {
    difference() {
      sphere(r = 20);
      sphere(r = 12);
    }
    translate([-1.5, 0, 0])    
      cube([3, 12, 20]);
  }
};

// гайка
module Nut() {
  difference() {
    intersection() {
      translate([-4, -4, 0])
        cube([8, 8, 4]);
      rotate([0, 0, 45])
        translate([-4, -4, 0])
          cube([8, 8, 4]);
    }
    cylinder(h = 4, r = 2);
  }
};

// головка болта
module ScrewHead() {
  cylinder(h = 3, r1 = 4.5, r2 = 2.5, center = false);
};

// собираем все в кучу
difference() {
  MainRing();
  // отверстия для болтов
  for (i = [1 : 8])
  {
    rotate([0, 0, 45 * i])
    translate([10, 0, 10])
    rotate([0, 90, 0])
      cylinder(h = 30, r = 2.5);
  }
  // пазы для венгерки стоек
  for (i = [1 : 2])
  {
    rotate([0, 0, 90 * i])
      translate([0, 18, 10])
        rotate([0, 30, 0])
          CurvedSlot();
  }
  for (i = [1 : 2])
  {
    rotate([0, 0, 180 + 90 * i])
      translate([0, 18, 10])
        rotate([0, -30, 0])
          CurvedSlot();
  }
  for (i = [1 : 2])
  {
    rotate([0, 0, 45 + 90 * i])
      translate([0, 18, 10])
        rotate([0, 30, 0])
          rotate([0, 180, 0])
            CurvedSlot();
  }
  for (i = [1 : 2])
  {
    rotate([0, 0, 225 + 90 * i])
      translate([0, 18, 10])
        rotate([0, -30, 0])
          rotate([0, 180, 0])
            CurvedSlot();
  }
  // шестигранники для гаек
  for (i = [1 : 8])
  {
    rotate([0, 0, 45 * i])
      translate([26, 0, 10])
        rotate([0, 90, 0])
          Nut();
  }
  // головки болтов
  for (i = [1, 3, 4, 5, 7])
  {
    rotate([0, 0, 45 * i])
      translate([13.5, 0, 10])
        rotate([0, 90, 0])
          ScrewHead();
  };
  for (i = [2, 6])
  {
    rotate([0, 0, 45 * i])
      translate([14.5, 0, 10])
        rotate([0, 90, 0])
          ScrewHead();
  };
  translate([18.5, 0, 10])
    rotate([0, 90, 0])
      ScrewHead();
};
