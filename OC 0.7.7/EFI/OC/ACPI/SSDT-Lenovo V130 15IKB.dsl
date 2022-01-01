/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210331 (64-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLQY4tFX.aml, Sat Oct 23 08:09:54 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000659 (1625)
 *     Revision         0x02
 *     Checksum         0x8E
 *     OEM ID           "HACK"
 *     OEM Table ID     "HackLife"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20210331 (539034417)
 */
DefinitionBlock ("", "SSDT", 2, "HACK", "HackLife", 0x00000000)
{
    External (_PR_.PR00, ProcessorObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0, IntObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFB, IntObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, IntObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.ADP1, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (BADR, FieldUnitObj)
    External (GNUM, MethodObj)    // 1 Arguments
    External (GPDI, FieldUnitObj)
    External (HID2, FieldUnitObj)
    External (HIDD, MethodObj)    // 5 Arguments
    External (HIDG, FieldUnitObj)
    External (INT1, FieldUnitObj)
    External (INT2, FieldUnitObj)
    External (INUM, MethodObj)    // 1 Arguments
    External (OSYS, FieldUnitObj)
    External (SDM0, FieldUnitObj)
    External (SDS0, FieldUnitObj)
    External (SPED, FieldUnitObj)
    External (TP7D, MethodObj)    // 6 Arguments
    External (TP7G, FieldUnitObj)
    External (TPDB, FieldUnitObj)
    External (TPDH, FieldUnitObj)
    External (TPDS, FieldUnitObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            SDS0 = 0x03
        }

        Scope (_PR)
        {
            Scope (PR00)
            {
                If (_OSI ("Darwin"))
                {
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If ((Arg2 == Zero))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                             // .
                            })
                        }

                        Return (Package (0x02)
                        {
                            "plugin-type", 
                            One
                        })
                    }
                }
            }
        }

        Scope (_SB)
        {
            Scope (PCI0)
            {
                Scope (GFX0)
                {
                    Device (PNLF)
                    {
                        Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                        Name (_CID, "backlight")  // _CID: Compatible ID
                        Name (_UID, 0x10)  // _UID: Unique ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                If (_OSI ("Darwin"))
                {
                    Scope (I2C0)
                    {
                        Device (TPDX)
                        {
                            Name (HID2, Zero)
                            Name (_STA, 0x0F)  // _STA: Status
                            Name (SBFB, ResourceTemplate ()
                            {
                                I2cSerialBusV2 (0x0020, ControllerInitiated, 0x00061A80,
                                    AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                                    0x00, ResourceConsumer, _Y00, Exclusive,
                                    )
                            })
                            Name (SBFI, ResourceTemplate ()
                            {
                                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y01)
                                {
                                    0x00000000,
                                }
                            })
                            Name (SBFG, ResourceTemplate ()
                            {
                                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                                    )
                                    {   // Pin list
                                        0x0000
                                    }
                            })
                            CreateWordField (SBFB, \_SB.PCI0.I2C0.TPDX._Y00._ADR, BADR)  // _ADR: Address
                            CreateDWordField (SBFB, \_SB.PCI0.I2C0.TPDX._Y00._SPE, SPED)  // _SPE: Speed
                            CreateWordField (SBFG, 0x17, INT1)
                            CreateDWordField (SBFI, \_SB.PCI0.I2C0.TPDX._Y01._INT, INT2)  // _INT: Interrupts
                            Name (_HID, "XXXX0000")  // _HID: Hardware ID
                            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
                            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
                            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                            {
                                If ((Arg0 == HIDG))
                                {
                                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                                }

                                If ((Arg0 == TP7G))
                                {
                                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                                }

                                Return (Buffer (One)
                                {
                                     0x00                                             // .
                                })
                            }

                            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                            {
                                Return (ConcatenateResTemplate (SBFB, SBFG))
                            }

                            Method (_INI, 0, NotSerialized)  // _INI: Initialize
                            {
                                INT1 = GNUM (GPDI)
                                INT2 = INUM (GPDI)
                                _HID = "SYNA2B61"
                                HID2 = TPDH /* External reference */
                                BADR = TPDB /* External reference */
                                If ((TPDS == Zero))
                                {
                                    SPED = 0x000186A0
                                }

                                If ((TPDS == One))
                                {
                                    SPED = 0x00061A80
                                }

                                If ((TPDS == 0x02))
                                {
                                    SPED = 0x000F4240
                                }
                            }
                        }
                    }
                }

                Scope (LPCB)
                {
                    Device (ALS0)
                    {
                        Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
                        Name (_CID, "smc-als")  // _CID: Compatible ID
                        Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
                        Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
                        {
                            Package (0x02)
                            {
                                0x64, 
                                0x012C
                            }
                        })
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Device (DMAC)
                    {
                        Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                        {
                            IO (Decode16,
                                0x0000,             // Range Minimum
                                0x0000,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IO (Decode16,
                                0x0081,             // Range Minimum
                                0x0081,             // Range Maximum
                                0x01,               // Alignment
                                0x11,               // Length
                                )
                            IO (Decode16,
                                0x0093,             // Range Minimum
                                0x0093,             // Range Maximum
                                0x01,               // Alignment
                                0x0D,               // Length
                                )
                            IO (Decode16,
                                0x00C0,             // Range Minimum
                                0x00C0,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            DMA (Compatibility, NotBusMaster, Transfer8_16, )
                                {4}
                        })
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Device (EC)
                    {
                        Name (_HID, "ACID0001")  // _HID: Hardware ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Scope (EC0)
                    {
                        Scope (ADP1)
                        {
                            If (_OSI ("Darwin"))
                            {
                                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                                {
                                    0x1C, 
                                    0x03
                                })
                            }
                        }
                    }
                }

                Device (MCHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Scope (SBUS)
                {
                    Device (BUS0)
                    {
                        Name (_CID, "smbus")  // _CID: Compatible ID
                        Name (_ADR, Zero)  // _ADR: Address
                        Device (DVL0)
                        {
                            Name (_ADR, 0x57)  // _ADR: Address
                            Name (_CID, "diagsvault")  // _CID: Compatible ID
                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If (!Arg2)
                                {
                                    Return (Buffer (One)
                                    {
                                         0x57                                             // W
                                    })
                                }

                                Return (Package (0x02)
                                {
                                    "address", 
                                    0x57
                                })
                            }
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                Device (SRAM)
                {
                    Name (_ADR, 0x00140002)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
            }

            Device (USBX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x04)
                    {
                        "kUSBSleepPortCurrentLimit", 
                        0x0BB8, 
                        "kUSBWakePortCurrentLimit", 
                        0x0BB8
                    })
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (_OSI ("Darwin"))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }
    }
}

